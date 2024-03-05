<template>
  <div>
    <div class="signup-form">
      <div type="is-danger" v-if="error">{{ error }}</div>
      <div class="signup-username">
        <b-field label="Pseudonyme" horizontal>
          <b-input maxlength="30" v-model="username"></b-input>
        </b-field>
      </div>
      <div class="signup-email">
        <b-field label="Email" horizontal>
          <b-input type="email" maxlength="30" v-model="email">
          </b-input>
        </b-field>
      </div>
      <div class="signup-password">
        <b-field label="Mot de passe" horizontal>
          <b-input type="password" password-reveal v-model="password">
          </b-input>
        </b-field>
      </div>
      <div class="signup-password-confirmation">
        <b-field label="Confirmer mot de passe" horizontal>
          <b-input type="password" password-reveal v-model="password_confirmation">
          </b-input>
        </b-field>
      </div>
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
      this.$router.replace('/signin')
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
}

.signup-form {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 200px;
}

.signup-btn {
  margin-top: 30px;
  width: 10%;
  color: white;
}

.signup-email {
  margin-top: 20px;
  width: 40%;
}

.signup-password {
  margin-top: 20px;
  width: 40%;
}

.signup-username {
  margin-top: 20px;
  width: 40%;
}

.signup-password-confirmation {
  margin-top: 20px;
  width: 40%;
}
</style>
