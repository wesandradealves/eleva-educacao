import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import VueAxios from 'vue-axios'
import NProgress from 'nprogress'
import router from '@/router'

Vue.use(Vuex, VueAxios, axios)

export default new Vuex.Store({
  state: {
    err: {
      status: false,
      title: '',
      msg: ''
    }
  },
  actions: {
    _doLogout({dispatch, state, getters, commit}){
      sessionStorage.clear()
      router.replace('/').catch(err => { return false })
    },
    _doRequest({dispatch, state, getters, commit}, body){
      return new Promise((resolve, reject) => {
        if(body.data) {
          axios({
            method: body.method,
            url: body.endpoint,
            data: (body.data) ? body.data : null,
            headers: {
              'Content-Type': (body.data) ? 'application/x-www-form-urlencoded' : null
            },            
            validateStatus: (status) => {
              return true; 
            },
          }).catch(error => {
              reject(error)
          }).then(response => {
              resolve(response)
          })
        } else {
          axios({
            method: body.method,
            url: body.endpoint,
            validateStatus: (status) => {
              return true; 
            },
          }).catch(error => {
              reject(error)
          }).then(response => {
              resolve(response)
          })                        
        }
                
      })          
    }     
  }
})
