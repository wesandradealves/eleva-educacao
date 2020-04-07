<template>
    <transition name="fade" mode="out-in">
      <div
        id="wrap"
        :class="[`${ $route.name === 'PageNotFound' ? 'page-not-found' : $route.name === 'login' ? $route.name : 'dashboard ' + $route.name }`, $store.state.confirmation ? 'blurred' : '']"    
      >
          <main>
            <router-view />
          </main>
          <md-dialog-alert
            :md-active.sync="$store.state.err.status"
            :md-title="$store.state.err.title"
            :md-content="$store.state.err.msg" />            
      </div>
    </transition>  
</template>
<script>
import Vue from 'vue'
import store from '@/store'
import VueMaterial from 'vue-material'

Vue.use(VueMaterial)

export default { 
  name: 'App'
}

</script>
<style lang="sass">
@import '../node_modules/vue-material/dist/vue-material.min.css'
@import '../node_modules/vue-material/dist/theme/default.css'
@import '../node_modules/nprogress/nprogress.css'; 
@import '../node_modules/bootstrap/scss/bootstrap.scss'; 
@import './assets/sass/tools/_globals';
@import './assets/sass/tools/_colors';
@import './assets/sass/tools/_fonts'; 
@import './assets/sass/tools/_general';
@import './assets/sass/tools/_reset';
@import './assets/sass/tools/_objects';

.select 
  label  
    top: 0
form 
  .md-button 
    margin-left: 0
.md-field.md-theme-default.md-has-value .select label
  top: -20px
</style>