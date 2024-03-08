<template lang="">
  <div>
      <div v-if="!signedIn()" class="centered">
        <div class="container-if-not-signin">
    <div class="content-if-not-signin">
        <b-message type="is-danger" class="mr-3">
          Vous devez être connecté pour publier une annonce
        </b-message>
        <router-link to="/signin">
          <b-button type="is-primary" class="signin-btn">Se connecter</b-button>
        </router-link>
        <p class="signup">Vous n'avez pas de compte ?</p>
        <router-link to="/signup">
          <p class="signup-link">Créer un compte</p>
        </router-link>
      </div>
    </div>
  </div>
      <div v-else>
        <div class="steps-container">
        <b-steps class="steps">
        <b-step-item class="step-item" label="Catégorie" icon="bars">
          <b-field label="Sélectionnez une catégorie">
            <b-select icon="bars">
                <optgroup label="Bonsaï">
                    <option value="flint">Bonsaï</option>
                    <option value="silver">Prébonsaï</option>
                    <option value="vane">Yamadori</option>
                    <option value="billy">Plant de pépinière</option>
                </optgroup>

                <optgroup label="Poterie">
                    <option value="heisenberg">Pot rond</option>
                    <option value="jesse">Pot rectangulaire</option>
                    <option value="saul">Pot spéciaux</option>
                    <option value="mike">Pot mame</option>
                </optgroup>

                <optgroup label="Outillage">
                    <option value="tyrion-lannister">Coupe</option>
                    <option value="jamie-lannister">Ligaturage</option>
                    <option value="daenerys-targaryen">Rempotage</option>
                    <option value="jon-snow">Arrosage</option>
                </optgroup>
            </b-select>
        </b-field>
        </b-step-item>
        <b-step-item class="step-item" label="Détails" icon="info">
          <b-field label="Titre">
            <b-input v-model="name"></b-input>
        </b-field>
        <b-field label="Localisation">
            <b-input v-model="name"></b-input>
        </b-field>
        <b-field label="Prix">
            <b-input v-model="name"></b-input>
        </b-field>
        <b-field label="Description">
            <b-input maxlength="200" type="textarea"></b-input>
        </b-field>
        <b-field>
            <b-upload v-model="dropFiles"
                multiple
                drag-drop>
                <section class="section">
                    <div class="content has-text-centered">
                        <p>
                            <b-icon
                                icon="upload"
                                size="is-large">
                            </b-icon>
                        </p>
                        <p>Drop your files here or click to upload</p>
                    </div>
                </section>
            </b-upload>
        </b-field>

        <div class="tags">
            <span v-for="(file, index) in dropFiles"
                :key="index"
                class="tag is-primary" >
                {{file.name}}
                <button class="delete is-small"
                    type="button"
                    @click="deleteDropFile(index)">
                </button>
            </span>
        </div>
        </b-step-item>
        <b-step-item class="step-item" label="Confirmer" icon="check"></b-step-item>
    </b-steps>
    </div>
      </div>
    </div>
</template>

<script>
export default {
  name: 'CreateAd',
  data () {
    return {
      dropFiles: []
    }
  },
  created () {
    this.signedIn()
  },
  methods: {
    deleteDropFile (index) {
      this.dropFiles.splice(index, 1)
    },
    signedIn () {
      return localStorage.signedIn
    }
  }
}
</script>

<style scoped lang="">
* {
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}

.steps-container {
  margin-top: 50px;

}

.signup-link {
  color: #618264;
  text-decoration: underline;
  cursor: pointer;
}

.signup {
  margin-top: 20px;
}

.container-if-not-signin {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 60%;
  margin: 100px auto;
  margin-top: 100px;
  border: 1px solid #ddd;
  background-color: white;
  padding: 20px;
  border-radius: 5px;
}

.content-if-not-signin {
  text-align: center;
}

.signin-btn {
  width: 40%;
  color: white;
  background-color: #618264;
}

.signin-btn:hover {
  background-color: #79AC78;
}
</style>
