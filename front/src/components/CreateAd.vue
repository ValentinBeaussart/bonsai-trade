<template lang="">
  <div>
  <div v-if="!signedIn()">
    <b-message type="is-danger">
      Vous devez être connecté pour publier une annonce
        </b-message>
    <router-link to="/signin"><b-button type="is-primary" class="signin-btn">Se connecter</b-button>
</router-link>
  </div>
  <div v-else>
    <h1>Publier une annonce</h1>
    <form>
      <div class="form-group">
        <input type="text" class="form-control" id="title" v-model="title">
      </div>
    </form>
  </div>
    </div>
</template>

<script>
export default {
  name: 'CreateAd',
  created () {
    this.signedIn()
  },
  methods: {
    signedIn () {
      return localStorage.signedIn
    }
  }
}
</script>
