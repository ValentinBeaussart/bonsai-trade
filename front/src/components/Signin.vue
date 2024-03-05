<template>
  <div>
    <div class="signin-form">
      <div type="is-danger" v-if="error">{{ error }}</div>
      <div class="signin-email">
        <b-field label="Email">
          <b-input placeholder="bonsaitrade@bonsai.fr" type="email" icon-pack="fas" icon="envelope" v-model="email">
          </b-input>
        </b-field>
      </div>
      <div class="signin-password">
        <b-field label="Mot de passe">
          <b-input placeholder="IloveBonsai" type="password" password-reveal v-model="password">
          </b-input>
        </b-field>
      </div>
      <b-button @click="signin" type="is-primary" class="signin-btn">Se connecter</b-button>
    </div>

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
      this.$router.replace('/home')
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
.signin-form {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 200px;
}

.signin-btn {
  margin-top: 30px;
  width: 10%;
  color: white;
}

.signin-email{
  width: 40%;
}

.signin-password {
  margin-top: 20px;
  width: 40%;
}
  </style>
