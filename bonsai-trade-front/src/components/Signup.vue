<template>
  <div>
    <div class="signup-form">
      <b-form-group label="Nom d'utilisateur" :state="usernameState">
        <b-form-input id="input-username" type="text" v-model="username" :state="usernameState" trim
          placeholder="BonsaiTradeDu69"></b-form-input>
        <div v-if="usernameError" class="text-danger">Veuillez saisir votre nom d'utilisateur.</div>
      </b-form-group>
      <b-form-group class="mt-3" label="Email" :state="emailState">
        <b-form-input id="input-email" type="email" v-model="email" :state="emailState" trim
          placeholder="bonsai-trade@contact.fr"></b-form-input>
        <div v-if="emailError" class="text-danger">Veuillez saisir votre adresse email.</div>
      </b-form-group>
      <b-form-group class="mt-3" label="Mot de passe" :state="passwordState">
        <b-form-input id="input-password" type="password" v-model="password" :state="passwordState" trim
          placeholder="Ilovebonsai123456789"></b-form-input>
        <div v-if="passwordError" class="text-danger">Veuillez saisir votre mot de passe.</div>
      </b-form-group>
      <b-form-group class="mt-3" label="Confirmer le mot de passe" :state="passwordConfirmationState">
        <b-form-input id="input-password_confirmation" type="password" v-model="password_confirmation"
          :state="passwordConfirmationState" trim placeholder="Ilovebonsai123456789"></b-form-input>
        <div v-if="passwordConfirmationError" class="text-danger">Veuillez confirmer votre mot de passe.</div>
      </b-form-group>
      <b-alert class="alert-password-email" v-if="error" show variant="danger">{{ error }}</b-alert>
      <b-button :class="{ 'signup-btn-alert-active': error, 'signup-btn-error-inactive': !error }" @click="signup">Créer un compte</b-button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      username: '',
      email: '',
      password: '',
      password_confirmation: '',
      error: '',
      usernameState: null,
      emailState: null,
      passwordState: null,
      passwordConfirmationState: null,
      usernameError: false,
      emailError: false,
      passwordError: false,
      passwordConfirmationError: false
    }
  },
  methods: {
    signup () {
      this.usernameState = !!this.username
      this.emailState = !!this.email
      this.passwordState = !!this.password
      this.passwordConfirmationState = !!this.password_confirmation

      this.usernameError = !this.username
      this.emailError = !this.email
      this.passwordError = !this.password
      this.passwordConfirmationError = !this.password_confirmation

      if (!this.username || !this.email || !this.password || !this.password_confirmation) {
        return
      }

      this.$http.plain.post('/signup', {
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation,
        username: this.username
      })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      window.location.reload()
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Un problème est survenu. Veuillez réessayer.'
      delete localStorage.csrf
      delete localStorage.signedIn
    }
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');

* {
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}

.alert-password-email {
  margin-top: 20px;
}

.signup-btn-alert-active:hover {
  background-color: #79AC78;
  border-color: transparent;
}

.signup-btn-error-inactive:hover {
  background-color: #79AC78;
  border-color: transparent;
}

.signup-btn-alert-active {
  margin-top: 10px;
  color: white;
  background-color: #618264;
  border-color: transparent;
}

.signup-btn-error-inactive {
  margin-top: 30px;
  transition: margin-top 0.3s ease;
  color: white;
  background-color: #618264;
  border-color: transparent;
}

.signup-form {
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

#input-username, #input-email, #input-password, #input-password_confirmation {
  width: 50vh;
}
</style>
