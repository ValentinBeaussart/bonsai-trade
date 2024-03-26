<template>
  <div class="wrapper">
    <div class="content">
      <div class="footer">
        <div>&copy;<span>{{ currentYear }}</span><span> Bonsai Trade. Tous droits réservés.</span></div>
      </div>
    </div>
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

<style scoped>
.wrapper {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.content {
  flex: 1;
}

.footer {
  padding: 2rem;
  background: #618264;
  color: white;
  font-weight: 500;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.2rem;
}
</style>
