<template>
	<section class="dashboard w-100 vh-100 row no-gutters overflow-hidden ">
		<sidebar :classes="'sidebar col-sm-12 col-md-3 no-gutters'" />
		<div class="dashbard-content col-sm-12 col-md-9 no-gutters p-5">
			<router-view />
		</div>
	</section>
</template>

<script>
import sidebar from "@/components/sidebar/sidebar"

export default {
  beforeRouteEnter(to, from, next) {
    next(vm => {
    	if(!sessionStorage.getItem('token') || !sessionStorage.getItem('user')) {
	      	vm.$router.replace('/').catch(err => { return false }) 
	      	sessionStorage.clear()
    	} else {
        vm.$router.replace(`/dashboard/listar/${(to.params.table) ? to.params.table : 'users'}`).catch(err => { return false }) 
    	}
    })    
  },   
  name: 'dashboard',
  components: {
  	sidebar
  },
  data () {
    return {

    }
  }
}
</script>

<style lang="sass">
@import '../../assets/sass/tools/_mixins'
.dashboard
  &-content 
    overflow: auto
</style>