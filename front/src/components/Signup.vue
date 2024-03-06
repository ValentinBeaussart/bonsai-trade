<template>
  <div>
    <div class="signup-form">
      <div type="is-danger" v-if="error">{{ error }}</div>
      <b-field class="signup-input" label="Nom d'utilisateur">
        <b-input placeholder="Valentin" v-model="username" type="username" icon-pack="fas" icon="user">
        </b-input>
      </b-field>
      <b-field class="signup-input" label="Email">
        <b-input placeholder="bonsai.trade@bonsai.com" v-model="email" type="email" icon-pack="fas" icon="envelope">
        </b-input>
      </b-field>
      <b-field class="signup-input" label="Mot de passe">
        <b-input placeholder="123456789" v-model="password" password-reveal type="password" icon-pack="fas" icon="lock">
        </b-input>
      </b-field>
      <b-field class="signup-input" label="Confirmer mot de passe">
        <b-input placeholder="123456789" v-model="password_confirmation" password-reveal type="password" icon-pack="fas"
          icon="lock">
        </b-input>
      </b-field>
      <b-button @click="signup" type="is-primary" class="signup-btn">Créer un compte</b-button>
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
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
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
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/signin')
      }
    }
  }
}
</script>

<style scoped>
.signup-btn {
  margin-top: 30px;
  width: 10%;
  color: white;
  background-color: #618264;
}

.signup-btn:hover {
  background-color: #79AC78;
}

.signup-form {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 100px;
}

.signup-input {
  margin-top: 20px;
  width: 40%;
}
</style>
