<template>
  <form @submit="login" class="overflow-hidden w-100 vh-100 row no-gutters">
    <div class="order-2 order-lg-1 col-md-12 col-lg-4 row justify-content-center align-items-center no-gutters form-fields">
      <div class="col-12 p-3"> 
        <div class="avatar mb-5 mx-auto d-none d-lg-block" :style="{ backgroundImage: 'url(data:image/png;base64,'+_user.file+' )' }" v-if="_user.file"></div>
        <svg v-else class="m-auto d-none d-lg-block" id="Capa_1" enable-background="new 0 0 551.13 551.13" height="512" viewBox="0 0 551.13 551.13" width="512" xmlns="http://www.w3.org/2000/svg"><path d="m275.565 0c-151.944 0-275.565 123.621-275.565 275.565s123.621 275.565 275.565 275.565 275.565-123.621 275.565-275.565-123.621-275.565-275.565-275.565zm0 34.446c132.955 0 241.119 108.164 241.119 241.119 0 55.39-18.966 106.322-50.483 147.077-120.888-57.212-260.386-57.212-381.272 0-31.517-40.755-50.483-91.687-50.483-147.077 0-132.955 108.164-241.119 241.119-241.119zm-166.474 415.125c106.268-47.069 226.68-47.069 332.948 0-43.324 41.466-101.909 67.115-166.474 67.115s-123.15-25.65-166.474-67.115z"/><path d="m275.565 344.456c56.983 0 103.337-46.353 103.337-103.337s-46.354-103.337-103.337-103.337-103.337 46.353-103.337 103.337 46.354 103.337 103.337 103.337zm0-172.228c37.995 0 68.891 30.897 68.891 68.891 0 37.995-30.897 68.891-68.891 68.891-37.995 0-68.891-30.897-68.891-68.891s30.897-68.891 68.891-68.891z"/></svg>      
        <md-field :class="submited&&!loginForm.username ? 'md-invalid' : ''">
          <label>Username</label>
          <md-input @keyup="getUser" v-model="loginForm.username"></md-input>
          <span class="md-error">Campo brigatório</span>
        </md-field>    
        <md-field :class="submited&&!loginForm.password ? 'md-invalid' : ''">
          <label>Password</label>
          <md-input @keyup="checkPassword" v-model="loginForm.password" type="password"></md-input>
          <span class="md-error">Campo brigatório</span>
        </md-field>
        <button class="btn btn-1">Entrar</button>        
      </div>      
    </div>
    <div class="order-1 order-lg-2 col-md-12 col-lg-8 row justify-content-center align-items-center no-gutters p-3 p-lg-0">
      <img src="@/assets/cropped-logo_eleva.png" alt="">
    </div>
  </form>
</template>

<script>
var md5 = require('md5')
var TokenGenerator = require('uuid-token-generator')

export default {
  beforeRouteEnter(to, from, next) {
    next(vm => {
      if(sessionStorage.getItem('token') && sessionStorage.getItem('user')) {
        vm.$router.replace('/dashboard').catch(err => { return false }) 
      }
    })    
  }, 
  name: 'login',
  mounted() {
    clearTimeout(this.timeout)
  },
  methods: {
    checkPassword() {
      let self = this
      
      clearTimeout(self.timeout)
      self.errors = self.$store.state.err.status = false
      self.$store.state.err.title = ''
      self.$store.state.err.msg = ''       
      
      self.timeout = setTimeout(function () {
        self.$store.dispatch('_doRequest', {
          method: 'GET', 
          endpoint: process.env.API_URL + '/?env=users',
        }).then(response => {
          if(response.data.filter(user=>user.username === self.loginForm.username).length) {
            let user = response.data.filter(user=>user.username === self.loginForm.username)[0]
            if(self.loginForm.password && 
              user.password !== md5(self.loginForm.password)) {
              self.$store.state.err.status = !self.$store.state.err.status
              self.$store.state.err.title = 'Senha inválida'
              self.$store.state.err.msg = 'Sua senha está incorreta!' 
            }
          }
        }, error => {
          console.log(error)
        })                  
      }, 500);      
    },
    getUser() {
      var self = this

      self.$store.dispatch('_doRequest', {
        method: 'GET', 
        endpoint: process.env.API_URL + '/?env=users',
      }).then(response => {
        self.user = !response.data.filter(user => user.username === self.loginForm.username).length ? response.data.filter(user => user.username === self.loginForm.username) : response.data.filter(user => user.username === self.loginForm.username)[0]
      }, error => {
        console.log(error)
      })       
    },
    login(e) {
      let self = this 
      let token = new TokenGenerator(256, TokenGenerator.BASE62)

      if(!self.loginForm.password || !self.loginForm.username) {
        self.submited = !self.submited
      } else {
        self.$store.dispatch('_doRequest', {
          method: 'GET', 
          endpoint: process.env.API_URL + '/?env=users',
        }).then(response => {
          if(response.data.filter(user=>user.username === self.loginForm.username).length) {
            let user = response.data.filter(user=>user.username === self.loginForm.username)[0]

            if(self.loginForm.password && 
              user.password !== md5(self.loginForm.password)) {
              self.$store.state.err.status = !self.$store.state.err.status
              self.$store.state.err.title = 'Senha inválida'
              self.$store.state.err.msg = 'Sua senha está incorreta!' 
            } else {
              self.$router.push('dashboard').catch(err => { return false }) 
              sessionStorage.setItem('user', JSON.stringify(user))
              sessionStorage.setItem('token', token.baseEncoding)
            }
          }
        }, error => {
          console.log(error)
        })         
      }
      e.preventDefault();
    }
  },
  computed: {
    _password() {
      return this.checkPassword()
    },
    _user() {
      return this.user
    }
  },
  data () {
    return {
      submited: false,
      user: [],
      errors: false,
      timeout: null,
      loginForm: {
        username: '',
        password: '',
        email: ''
      }
    }
  }
}
</script>

<style lang="sass">
@import '../../assets/sass/tools/_mixins'
.login 
  .form-fields
    +mq(991px, min)
      background-color: transparentize(cadetblue, .6)
    .md-field.md-theme-default:before
      background-color: cadetblue
    .md-field.md-theme-default.md-focused label
      color: cadetblue    
    svg, .avatar
      height: 140px 
      max-width: 100%
      fill: transparentize(gray, .4)
    .avatar 
      max-width: 50%
      padding: 0 0 50%
      background-size: cover
      background-position: center
      background-repeat: no-repeat
      border-radius: 9999px
</style>