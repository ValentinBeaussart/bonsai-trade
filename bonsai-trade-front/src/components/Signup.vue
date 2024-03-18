<template>
  <div>
      <div class="signup-form">
        <div type="is-danger" v-if="error">{{ error }}</div>
        <!-- <b-field class="signup-input" label="Nom d'utilisateur">
          <b-input placeholder="ValentinBonsai" v-model="username" type="username" icon-pack="fas" icon="user">
          </b-input>
        </b-field>
        <b-field class="signup-input" label="Email">
          <b-input placeholder="bonsai-trade@contact.fr" v-model="email" type="email" icon-pack="fas" icon="envelope">
          </b-input>
        </b-field>
        <b-field class="signup-input" label="Mot de passe">
          <b-input placeholder="Ilovebonsai123456789" v-model="password" password-reveal type="password" icon-pack="fas"
            icon="lock">
          </b-input>
        </b-field>
        <b-field class="signup-input" label="Confirmer mot de passe">
          <b-input placeholder="Ilovebonsai123456789" v-model="password_confirmation" password-reveal type="password"
            icon-pack="fas" icon="lock">
          </b-input>
        </b-field>
        <b-button @click="signup" type="is-primary" class="signup-btn">Créer un compte</b-button> -->
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
      this.error = (error.response && error.response.data && error.response.data.error) || 'Un problème est survenu. Veuillez réessayer.'
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
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}

.signup-btn {
  margin-top: 30px;
  width: 20%;
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
  width: 60%;
  margin: 100px auto;
  margin-top: 100px;
  border: 1px solid #ddd;
  background-color: white;
  padding: 20px;
  border-radius: 5px;
}

.signup-input {
  margin-top: 20px;
  width: 40%;
}
</style>
