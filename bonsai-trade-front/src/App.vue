
<template>
  <div id="app">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
    <Navbar></Navbar>
    <router-view/>
    <Footer></Footer>
  </div>
</template>

<script>
import Navbar from './components/Navbar.vue'
import Footer from './components/Footer.vue'
export default {
  components: {
    Navbar,
    Footer
  },
  name: 'App'
}
</script>

<style>
html, body, #app{
  height: 100%;
  margin: 0;
  padding: 0;
}

body {
  background-image: url('./assets/vigne-vierge.jpg');
}

</style>
