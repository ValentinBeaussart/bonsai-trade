<template>
    <div class="signin-form">
      <div type="is-danger" v-if="error">{{ error }}</div>
      <div class="signin-email">
        <b-field label="Email">
          <b-input placeholder="bonsai-trade@contact.fr" type="email" icon-pack="fas" icon="envelope" v-model="email">
          </b-input>
        </b-field>
      </div>
      <div class="signin-password">
        <b-field label="Mot de passe">
          <b-input placeholder="Ilovebonsai123456789" type="password" password-reveal v-model="password" icon-pack="fas"
          icon="lock">
          </b-input>
        </b-field>
      </div>
      <b-button @click="signin" type="is-primary" class="signin-btn">Se connecter</b-button>
    </div>
</template>
<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      window.location.reload()
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
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
  margin: 0;
  padding: 0;
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
  width: 20%;
  color: white;
  background-color: #618264;
}

.signin-btn:hover {
  background-color: #79AC78;
}

.signin-email{
  margin-top: 20px;
  width: 40%;
}

.signin-password {
  margin-top: 20px;
  width: 40%;
}
  </style>
