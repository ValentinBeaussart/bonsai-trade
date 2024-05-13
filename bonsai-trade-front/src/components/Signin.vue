<template>
  <div class="signin-form">
    <b-form-group label="Email" :state="emailState">
      <b-form-input id="input-email" type="email" v-model="email" :state="emailState" trim
        placeholder="bonsai-trade@contact.fr"></b-form-input>
      <div v-if="emailError" class="text-danger">Veuillez saisir votre adresse email.</div>
    </b-form-group>
    <b-form-group class="mt-3" label="Mot de passe" :state="passwordState">
      <b-form-input id="input-password" type="password" v-model="password" :state="passwordState" trim
        placeholder="Ilovebonsai123456789"></b-form-input>
      <div v-if="passwordError" class="text-danger">Veuillez saisir votre mot de passe.</div>
    </b-form-group>
    <b-alert class="alert-password-email" v-if="error" show variant="danger">{{ error }}</b-alert>
    <b-button :class="{ 'signin-btn-alert-active': error, 'signin-btn-error-inactive': !error }" @click="signin">Se
      connecter</b-button>
    <router-link to="/new_password">
      <p class="signin-link">Mot de passe oublié ?</p>
    </router-link>
    <router-link to="/signup">
      <p class="signin-link">S'inscrire</p>
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: '',
      emailState: null,
      passwordState: null,
      emailError: false,
      passwordError: false
    }
  },
  methods: {
    signin () {
      if (!this.email) {
        this.emailState = false
        this.emailError = true
      } else {
        this.emailState = null
        this.emailError = false
      }

      if (!this.password) {
        this.passwordState = false
        this.passwordError = true
      } else {
        this.passwordState = null
        this.passwordError = false
      }

      if (!this.email || !this.password) {
        return
      }

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

.signin-link {
  color: #618264;
  text-decoration: underline;
  cursor: pointer;
  margin-top: 10px;
  margin-bottom: 0;
}

.alert-password-email {
  margin-top: 20px;
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

.signin-btn-alert-active:hover {
  background-color: #79AC78;
  border-color: transparent;
}

.signin-btn-error-inactive:hover {
  background-color: #79AC78;
  border-color: transparent;
}

.signin-btn-alert-active {
  margin-top: 10px;
  color: white;
  background-color: #618264;
  border-color: transparent;
}

.signin-btn-error-inactive {
  margin-top: 30px;
  transition: margin-top 0.3s ease;
  color: white;
  background-color: #618264;
  border-color: transparent;
}

#input-email, #input-password {
  width: 50vh;
}
</style>
