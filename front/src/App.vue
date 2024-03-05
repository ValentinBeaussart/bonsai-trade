<template>
  <div id="app">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
    <Navbar></Navbar>
    <Footer></Footer>
    <router-view/>
  </div>
</template>

<script>
import Home from './components/Home.vue'
import Navbar from './components/Navbar.vue'
import Footer from './components/Footer.vue'
export default {
  components: {
    Home,
    Navbar,
    Footer
  },
  name: 'App'
}
</script>

<style>

</style>
