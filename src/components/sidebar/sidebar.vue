<template>
	<aside :class="this.classes">
		<div class="sidebar-inner vh-100 d-flex flex-column justify-content-between pt-4 pb-4 p-2 overflow-auto">
			<img class="mx-auto d-block mb-5 p-2" src="@/assets/cropped-logo_eleva.png" alt="">
			<md-list>
				<md-list-item md-expand>
				  <md-icon>supervisor_account</md-icon>
				  <span class="md-list-item-text">Usuários</span>

				  <md-list slot="md-expand">
				    <md-list-item class="md-inset" @click="$router.push('/dashboard/listar/users').catch(err => { return false })">Listar</md-list-item>
				    <md-list-item class="md-inset" @click="$router.push('/dashboard/adicionar/users').catch(err => { return false })">Adicionar</md-list-item>
				  </md-list>
				</md-list-item>

				<md-list-item md-expand>
				  <md-icon>school</md-icon>
				  <span class="md-list-item-text">Escolas</span>

				  <md-list slot="md-expand">
				    <md-list-item class="md-inset" @click="$router.push('/dashboard/listar/escolas').catch(err => { return false })">Listar</md-list-item>
				    <md-list-item class="md-inset" @click="$router.push('/dashboard/adicionar/escolas').catch(err => { return false })">Adicionar</md-list-item>
				  </md-list>
				</md-list-item>						

				<md-list-item md-expand>
				  <md-icon>import_contacts</md-icon>
				  <span class="md-list-item-text">Turmas</span>

				  <md-list slot="md-expand">
				    <md-list-item class="md-inset" @click="$router.push('/dashboard/listar/turmas').catch(err => { return false })">Listar</md-list-item>
				    <md-list-item class="md-inset" @click="$router.push('/dashboard/adicionar/turmas').catch(err => { return false })">Adicionar</md-list-item>
				  </md-list>
				</md-list-item>		
			</md-list>	
			<md-button @click="$store.dispatch('_doLogout')" class="md-raised mt-auto d-block md-secondary">Logout</md-button>			
		</div>
	</aside>
</template>

<script>
export default {

  name: 'sidebar',
  props: ['classes'],
  data () {
    return {
    }
  }
}
</script>

<style lang="sass">
@import '../../assets/sass/tools/_mixins'
.sidebar 
	background-color: #474747
	img 
		filter: grayscale(1) invert(1) brightness(2)
		max-width: 160px
		width: 100%
	.md-list 
		padding: 0
		flex: 1
		overflow: auto 
		background-color: transparent
		&.md-theme-default 
			.md-list-item-expand:not(.md-list-item-default):not([disabled])>.md-list-item-content:hover
				color: white!important
		&-item-container
			color: white!important
			.md-icon.md-theme-default.md-icon-font
				color: inherit
				&.md-icon-image svg
					fill: white
</style>