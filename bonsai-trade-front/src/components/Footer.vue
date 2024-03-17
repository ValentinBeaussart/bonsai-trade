
<template lang="">
  <div>
    <div class="footer">&copy;<span> {{ currentYear }} </span><span> Bonsai Trade. Tous droits réservés.</span></div>
  </div>
</template>
<script>
export default {
  name: 'Footer',
  data () {
    return {
      currentYear: null
    }
  },
  mounted () {
    this.currentYear = new Date().getFullYear()
  }
}
</script>
<style scoped lang="">
.footer {
  bottom: 0;
  left: 0;
  right: 0;
  padding: 2rem;
  background: #618264;
  color: white;
  font-weight: 500;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.2rem;
  z-index: 999;
}
</style>
