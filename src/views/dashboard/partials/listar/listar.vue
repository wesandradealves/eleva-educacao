<template>
	<section>
		<h2 class="mb-4">{{vm._data.count}} resultado(s) para "{{vm._data.table}}"</h2>
    <ul class="results">
      <md-list-item :key="item.id" :id="`post_${item.id}`" v-for="item in vm._data.data">
        <md-avatar v-if="item.avatar">
          <img :src="'data:image/png;base64, ' + item.avatar" />
        </md-avatar>

        <span class="md-list-item-text">{{ (item.username) ? item.username : (item.escola&&!item.turma) ? item.escola : (item.turma) ? item.turma : item.nome }}</span>

        <md-button class="md-icon-button md-list-action" @click="editItem(item.id, vm._data.table)">
          <md-icon class="md-primary">create</md-icon>
        </md-button>

        <md-button v-if="item.id !== currentUser" class="md-icon-button md-list-action" @click="removeItem(item.id)">
          <md-icon class="md-primary">delete_sweep</md-icon>
        </md-button>        
      </md-list-item>        
    </ul>  
	</section>
</template>

<script>
import Vue from 'vue'
import router from '@/router'
import store from '@/store'

router.beforeEach((to, from, next) => {
  if(to.name === 'listar') {
    if(to.params) {
      if(to.params.table) {
        store.dispatch('_doRequest', {
          method: 'GET', 
          endpoint: process.env.API_URL + `/?env=${to.params.table}`,
        }).then(response => {
          vm._data.data = response.data 
          vm._data.table = to.params.table
          vm._data.count = response.data.length
        }, error => {
          console.log(error)
        })       
      }
    }    
  }

  next()
})

var vm = new Vue({
  data: {
    data: [],
    table: '',
    count: ''
  }
});

export default {

  name: 'listar',
  beforeRouteEnter(to, from, next) {
    next(self => {
      if(self.$route.params) {
        if(self.$route.params.table) {
          store.dispatch('_doRequest', {
            method: 'GET', 
            endpoint: process.env.API_URL + `/?env=${self.$route.params.table}`,
          }).then(response => {
            vm._data.data = response.data 
            vm._data.table = to.params.table
            vm._data.count = response.data.length
          }, error => {
            console.log(error)
          })       
        }
      }
    })    
  },    
  methods: {
    editItem(id, table) {
      this.$router.replace(`/dashboard/editar/${table}/${id}`).catch(err => { return false })
    },
    removeItem(id) {
      var self = this

      let body = []

      body.push({id: id}) 
      body.push({table: self.$route.params.table})

      self.$store.dispatch('_doRequest', {
        method: 'DELETE', 
        endpoint: process.env.API_URL,
        data: body,
      }).then(response => {
        self.$store.state.err.status = !self.$store.state.err.status

        if(response.status === 201) {
          document.getElementById(`post_${id}`).style.display = "none";

          vm._data.count = vm._data.count-=1;

          self.$store.state.err.title = 'Sucesso'
          self.$store.state.err.msg = 'Deletado com sucesso!'  

          self.$router.replace(`/dashboard/listar/${self.$route.params.table}`).catch(err => { return false })    
        } else {
          self.$store.state.err.title = 'Erro'
          self.$store.state.err.msg = 'Ocorreram erros ao deletar.'          
        }
      }, error => {
        console.log(error)
      })         
    },
  },
  computed: {
    currentUser() {
      return JSON.parse(sessionStorage.getItem('user')).id
    },
    vm() {
      return vm;
    }
  },  
  data () {
    return {
    }
  }
}
</script>

<style lang="sass">
@import '../../../../assets/sass/tools/_mixins';
.results 
  >li 
    box-shadow: 0px 0px 15px -10px black
    &:not(:last-child)
      margin-bottom: 15px
</style>