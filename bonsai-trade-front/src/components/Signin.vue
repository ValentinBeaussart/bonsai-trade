<template>
  <div class="signin-form">
    <div type="is-danger" v-if="error">{{ error }}</div>
    <b-form-group label="Email" :invalid-feedback="invalidFeedback" :state="state">
      <b-form-input id="input-1" type="email" v-model="email" :state="state" trim
        placeholder="bonsai-trade@contact.fr"></b-form-input>
    </b-form-group>
    <b-form-group class="mt-3" label="Mot de passe" :invalid-feedback="invalidFeedback" :state="state">
      <b-form-input id="input-1" type="password" v-model="password" :state="state" trim
        placeholder="Ilovebonsai123456789"></b-form-input>
    </b-form-group>
    <b-button class="signin-btn" @click="signin">Se connecter</b-button>
  </div>
</template>
<script>
export default {
  name: 'Signin',
  data() {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created() {
    this.checkSignedIn()
  },
  updated() {
    this.checkSignedIn()
  },
  methods: {
    signin() {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful(response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      window.location.reload()
    },
    signinFailed(error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn() {
      if (localStorage.signedIn) {
        this.$router.replace('/home')
      }
    }
  }
}
</script>
<style scoped lang="">
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
* {
box-sizing: border-box;
font-family: 'Poppins', sans-serif;
}

.signin-form {
display: flex;
flex-direction: column;
align-items: center;
justify-content: center;
width: 60%;
margin: 100px auto;
margin-top: 100px;
border: 1px solid #ddd;
background-color: white;
padding: 20px;
border-radius: 5px;
}

.signin-btn {
margin-top: 30px;
color: white;
background-color: #618264;
}

.signin-btn:hover {
background-color: #79AC78;
}
</style>
