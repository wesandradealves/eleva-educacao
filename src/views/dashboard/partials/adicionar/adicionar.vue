<template>
	<section>
		<h2 class="mb-4"><span>{{$route.name}}</span> {{ ($route.name === 'adicionar') ? 'novo' : '' }}</h2>
    <form @submit="submit">
      <div v-if="$route.params.table === 'users'" class="avatar mb-5 mx-auto d-none d-lg-block">
        <input type="file" @change="handleFile">
        <img :src="'data:image/png;base64, ' + base64File">
      </div>
      <div v-for="field in fields">
        <md-field v-if="field.type !== 'file' && field.type !== 'select'">
          <label>{{field.label}}</label>
          <md-input :required="true" v-model="formFields[field.name]" :value="formFields[field.name]" :type="field.type"></md-input>
        </md-field>   

        <md-field v-if="field.type === 'select'">
          <div :class="'select'">
            <label>{{field.label}}</label>
            <md-select :required="true" v-model="formFields[field.name]">
              <md-option 
              :key="option[($route.params.table === 'turmas') ? 'escola' : 'turma']"
              v-for="option in selects[($route.params.table === 'turmas') ? 'escolas' : 'turmas']" 
              :value="option[($route.params.table === 'turmas') ? 'escola' : 'turma']">{{option[($route.params.table === 'turmas') ? 'escola' : 'turma']}}</md-option>
            </md-select>      
          </div>
        </md-field>  

      </div>
      <md-button @click="submit" class="md-raised md-primary">{{ ($route.name === 'adicionar') ? 'Adicionar' : 'Editar' }}</md-button>
    </form>
	</section>
</template>

<script>
import Vue from "vue"
import axios from 'axios'
import VueAxios from 'vue-axios'
import router from '@/router'

Vue.use(VueAxios, axios)
var md5 = require('md5')

export default {

  name: 'adicionar',
  beforeRouteEnter (to, from, next) {
    next(vm => {
      vm.retrieveForm() 
    })     
  },  
  watch: {
    $route(to, from) {
      this.retrieveForm()  
    }
  },  
  methods: {
    async retrieveForm() {
      var vm = this
      return new Promise((resolve, reject) => {
        if(vm.$route.name === 'editar' || vm.$route.name === 'adicionar') {
          
            let table = vm.$route.params.table 
            let id = vm.$route.params.id

            switch(table) {
              case 'users' :
                vm.fields = [
                  {label: 'Username', name: 'username', type: 'text'},
                  {label: 'Password', name: 'password', type: 'password'},
                  {label: 'E-mail', name: 'email', type: 'email'},
                  {label: 'Avatar', name: 'file', type: 'file'}
                ] 
              break;
              case 'escolas' :
                vm.fields = [{label: 'Escola', name: 'escola', type: 'text'}] 
              break;
              case 'turmas' :
                vm.fields = [
                  {label: 'Turma', name: 'turma', type:'text'}, 
                  {label: 'Escola', name: 'escola', type: 'select'}
                ] 
              break;
              default:
              // 
            }            

            if(vm.$route.params.id) { 
              vm.$store.dispatch('_doRequest', {
                method: 'GET', 
                endpoint: process.env.API_URL + `/?id=${id}&table=${table}`, 
              }).then(response => {     
                if(response.data.filter(data=>data.id === id).length) {
                  let self = response.data.filter(data=>data.id === id)[0]

                  for (const [key, value] of Object.entries(self)) {
                    if(key !== 'id') {
                      vm.formFields.push(key);   

                      if(key !== 'password') {
                        vm.formFields[key] = value
                      } else {
                        vm.password = value
                      }
                    }
                  }       

                  vm.base64File = vm.formFields['file']

                  if(table === 'turmas') {
                    vm.getInfo()
                  }                  
                }
              }, error => {
                reject(error)
              })
          } else {
            for (var i = 0; i < vm.formFields.length; i++) {
              vm.formFields[vm.formFields[i]] = ''
            }
            vm.base64File = ''

            if(table === 'turmas') {
              vm.getInfo()
            }
          }
        }
      }) 
    },
    async getInfo() {
      var vm = this
      return new Promise((resolve, reject) => {
        function getEscolas() {
          vm.$store.dispatch('_doRequest', {
            method: 'GET', 
            endpoint: process.env.API_URL + '/?table=escolas', 
          }).then(response => {
            vm.selects.escolas = response.data
          }, error => {
            reject(error)
          }) 
        }   

        function getTurmas() {
          vm.$store.dispatch('_doRequest', {
            method: 'GET', 
            endpoint: process.env.API_URL + '/?table=turmas', 
          }).then(response => {
            vm.selects.turmas = response.data
          }, error => {
            reject(error)
          }) 
        }  

        axios.all([getEscolas(), getTurmas()])
        .then(axios.spread(function (acct, perms) {
          return true
        }))  
      }) 
    },
    submit(e) {
      var vm = this 
      var filter = ''

      this.$store.dispatch('_doRequest', {
        method: 'GET', 
        endpoint: process.env.API_URL + `/?table=${this.$route.params.table}`,
      }).then(response => {
        switch(vm.$route.params.table) {
          case 'users' : 
            filter = response.data.filter(data=>data.username === vm.formFields['username']).length
          break;
          case 'escolas' :
            filter = response.data.filter(data=>data.escola === vm.formFields['escola']).length
          break;
          case 'turmas' :
            filter = response.data.filter(data=>data.turma === vm.formFields['turma'] && data.escola === vm.formFields['escola']).length
          break;
          default:
          // 
        }
        
        if(!filter) {
          if(vm.base64File) {
            vm.formFields['file'] = vm.base64File
          }

          if(vm.formFields['password']) {
            if(vm.password !== md5(vm.formFields['password'])) {
              vm.formFields['password'] = md5(vm.formFields['password'])
            } else {
              vm.formFields['password'] = vm.password
            }
          } else {
            vm.formFields['password'] = vm.password
          }

          var body = []

          for (const [key, value] of Object.entries(vm.formFields)) {
            body.push({ [key]:value })
          }  

          if(vm.$route.params.id) {
            body.push( { id : vm.$route.params.id } )
          } 
          
          if(vm.$route.params.table) {
            body.push( { table : vm.$route.params.table } )
          }

          vm.$store.dispatch('_doRequest', {
            method: 'POST', 
            endpoint: process.env.API_URL + ( (vm.$route.params.id) ? `?id=${vm.$route.params.id}&table=${vm.$route.params.table}` : `?table=${vm.$route.params.table}` ),
            data: body,
          }).then(response => {
            vm.$store.state.err.status = !vm.$store.state.err.status
            if(response.status === 201) {
              vm.$store.state.err.title = 'Sucesso'
              vm.$store.state.err.msg = 'Salvo com sucesso!'     
            } else {
              vm.$store.state.err.title = 'Erro'
              vm.$store.state.err.msg = 'Ocorreram erros no seu formulário.'          
            }
          }, error => {
            console.log(error)
          })     

          if(vm.$route.params.table === 'users') {
            if(parseInt(JSON.parse(sessionStorage.getItem('user')).id) === parseInt(vm.$route.params.id)) {
              if( vm.formFields['password'] !== JSON.parse(sessionStorage.getItem('user')).password ) {
                vm.$store.dispatch('_doLogout')
              } else {
                vm.$router.replace(`/dashboard/listar/${vm.$route.params.table}`).catch(err => { return false }) 
              }
            } else {
                vm.$router.replace(`/dashboard/listar/${vm.$route.params.table}`).catch(err => { return false }) 
            }
          } else {
            vm.$router.replace(`/dashboard/listar/${vm.$route.params.table}`).catch(err => { return false }) 
          }
        } else {
          vm.$store.state.err.status = !vm.$store.state.err.status
          vm.$store.state.err.title = 'Erro'
          vm.$store.state.err.msg = 'Ocorreram erros no seu formulário ou o registro já consta em nosso banco de dados.'            
        }
      }, error => {
        console.log(error)
      })       
      e.preventDefault()
    },
    handleFile(e) {
        var self = this 

        const image2base64 = require('image-to-base64')

        let file = e.target.files[0]
        let base64 = ''

        image2base64(URL.createObjectURL(file) ) 
            .then(
                (response) => {
                  self.base64File = response
                } 
            )
            .catch(
                (error) => {
                    console.log(error); 
                }
            )    

    }
  },
  computed: {
    id() {
      return this.$router.params.id
    },    
    table() {
      return this.$router.params.table
    }
  },
  data () {
    return {
    	base64File: '',
      formFields: [],
      fields: [],
      password: '',
      selects: {
        escolas: [],
        turmas: []
      }
    }
  }
}
</script>
<style lang="sass">
.md-field[class*="file"]
  >div 
    width: 100%
  & label,
  & label
    top: 6px
  &.md-focused label,
  &.md-has-value label
    top: -15px  
h2 
	span 
		text-transform: capitalize    
.avatar 
  max-width: 140px
  padding: 0 0 140px
  background-size: cover
  background-position: center
  background-repeat: no-repeat
  border-radius: 9999px    
  overflow: hidden 
  position: relative
  object-fit: cover 
  background-color: whitesmoke
  img
    display: block 
    position: absolute 
    top: 0
    left: 0
    width: auto
    height: 120% 
    object-fit: cover
    z-index: 1
  input 
    z-index: 2
    position: absolute 
    top: 0
    left: 0
    display: block 
    height: 100%
    width: 100%
    cursor: pointer
    opacity: 0
</style>