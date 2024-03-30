<template>
  <div class="content">
    <div class="footer">
      <div>&copy;<span>{{ currentYear }}</span><span> Bonsai Trade. Tous droits réservés.</span></div>
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
.content {
  display: flex;
  flex-direction: column;
  height: 100%;
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
  margin-top: auto;
}
</style>
