<template lang="">
  <div>
      <div v-if="!signedIn()" class="centered">
        <div class="container-if-not-signin">
    <div class="content-if-not-signin">
      <b-alert show variant="danger">Vous devez être connecté pour publier une annonce</b-alert>
        <router-link to="/signin">
          <b-button class="btn">Se connecter</b-button>
        </router-link>
        <p class="signup">Vous n'avez pas de compte ?</p>
        <router-link to="/signup">
          <p class="signup-link">Créer un compte</p>
        </router-link>
      </div>
    </div>
  </div>
      <div v-else>
        <div v-if="currentStep === 1" class="create-ad-container">
          <h2 class="mb-5">Publier votre annonce</h2>
          <h4 class="mb-4">Choisissez une catégorie</h4>
          <b-form-select v-model="category" class="m-2 mb-4">
  <optgroup label="Bonsaï">
    <option value="Bonsaï">Bonsaï</option>
    <option value="Prébonsaï">Prébonsaï</option>
    <option value="Yamadori">Yamadori</option>
    <option value="Plant de pépinière">Plant de pépinière</option>
  </optgroup>
  <optgroup label="Poterie">
    <option value="Pot rond">Pot rond</option>
    <option value="Pot rectangulaire">Pot rectangulaire</option>
    <option value="Pot spéciaux">Pot spéciaux</option>
    <option value="Pot mame">Pot mame</option>
  </optgroup>
  <optgroup label="Outillage">
    <option value="Coupe">Coupe</option>
    <option value="Ligaturage">Ligaturage</option>
    <option value="Rempotage">Rempotage</option>
    <option value="Arrosage">Arrosage</option>
  </optgroup>
</b-form-select>
<b-button @click="nextStep" class="btn">Suivant</b-button>
<div class="create-ad-container" v-if="currentStep === 2">
  <h2 class="mb-5">Publier votre annonce</h2>
  <h4 class="mb-4">Informations</h4>
  <b-form-input v-model="name" placeholder="Titre" class="m-2 mb-4"></b-form-input>
  <b-form-input v-model="price" placeholder="Prix" type="number" class="m-2 mb-4"></b-form-input>
  <b-form-input v-model="place" placeholder="Localisation" class="m-2 mb-4"></b-form-input>
  <b-form-textarea v-model="description" placeholder="Description" rows="3" max-rows="6" class="m-2 mb-4"></b-form-textarea>
  <b-button @click="createAd" class="btn">Valider</b-button>
</div>
</div>
<!-- <b-form-group label="Titre" :state="usernameState">
        <b-form-input id="input-username" type="text" v-model="username" :state="usernameState" trim
          placeholder="BonsaiTradeDu69"></b-form-input>
        <div v-if="usernameError" class="text-danger">Veuillez saisir votre nom d'utilisateur.</div>
      </b-form-group>
      <b-form-group label="Titre" :state="usernameState">
        <b-form-input id="input-username" type="text" v-model="username" :state="usernameState" trim
          placeholder="BonsaiTradeDu69"></b-form-input>
        <div v-if="usernameError" class="text-danger">Veuillez saisir votre nom d'utilisateur.</div>
      </b-form-group>
      <b-form-group label="Titre" :state="usernameState">
        <b-form-textarea
      id="textarea"
      v-model="text"
      placeholder="Enter something..."
      rows="3"
      max-rows="6"
    ></b-form-textarea>
        <div v-if="usernameError" class="text-danger">Veuillez saisir votre nom d'utilisateur.</div>
      </b-form-group>
      <b-form-group label="Titre" :state="usernameState">
        <b-form-input id="input-username" type="text" v-model="username" :state="usernameState" trim
          placeholder="BonsaiTradeDu69"></b-form-input>
        <div v-if="usernameError" class="text-danger">Veuillez saisir votre nom d'utilisateur.</div>
      </b-form-group>
        <b-form-group label="Images" label-cols-sm="2">
    <b-form-file id="file-default"></b-form-file>
        <div v-if="usernameError" class="text-danger">Veuillez saisir votre nom d'utilisateur.</div>
      </b-form-group> -->

          <!-- <b-field label="Titre *">
            <b-input placeHolder="Azalée Satsuki" class="input-info" v-model="name"></b-input>
        </b-field>
        <b-field label="Localisation *">
            <b-input placeHolder="Lyon" class="input-info" v-model="place"></b-input>
        </b-field>
        <b-field label="Prix *">
            <b-input placeHolder="500" class="input-info" v-model="price"></b-input>
        </b-field>
        <b-field label="Description *">
            <b-input placeHolder="Jolie petite Azalée Satsuki, cultivée depuis 20 ans. Belle floraison printanière/estivale blanche. Prix négociable... " class="input-info"  v-model="description"
            maxlength="100" type="textarea"></b-input>
        </b-field>
        <b-field label="Ajouter des photos *">
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
                        <p>Déposez vos fichiers ici ou cliquez pour télécharger</p>
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
        <b-step-item class="step-item" label="Confirmer" icon="check">
          <p><strong>Catégorie :</strong> {{ category }}</p>
          <p><strong>Titre :</strong> {{ name }}</p>
          <p><strong>Prix :</strong> {{ price }} €</p>
          <p><strong>Localisation :</strong> {{ place }}</p>
          <p><strong>Description :</strong> {{ description }}</p>
          <b-button
               class="politics-btn"
                @click="confirmCustom">
                Règles à respecter
              </b-button>
        </b-step-item>

        <template v-if="customNavigation"
        #navigation="{previous, next}">
        <div class="btn-next-step-container">
          <b-button @click.prevent="previous.action" @click="currentStep-- && checkFields()"
    type="is-primary" class="next-previous-step-btn">Retour</b-button>
          <b-button v-if="currentStep === 1 || currentStep === 2" @click.prevent="next.action" @click="currentStep++ && checkFields()"
    type="is-primary" class="next-previous-step-btn" :disabled="!allFieldsFilled">Valider</b-button>
    <b-button v-if="currentStep === 3" @click="createAd()"
    type="is-primary" class="next-previous-step-btn">Valider</b-button>
  </div>
      </template>
</b-steps> -->

</div>
</div>
</template>

<script>
export default {
  name: 'CreateAd',
  data () {
    return {
      category: '',
      name: '',
      description: '',
      price: 0,
      place: '',
      dropFiles: [],
      currentStep: 1
    }
  },
  created () {
    this.signedIn()
  },
  methods: {
    signedIn () {
      return localStorage.signedIn
    },

    createAd () {
      this.$http.secured.post('/api/v1/ads/', { name: this.name, category_name: this.category, description: this.description, price: this.price, place: this.place })
        .then(() => {
          this.success()
          setTimeout(() => {
            window.location.reload()
          }, 1500)
        })
        .catch(error => this.setError(error, 'Impossible de créer votre annonce'))
    },
    nextStep () {
      this.currentStep++
    }
  }
}
</script>

<style scoped lang="">
* {
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
  height: auto;
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

.btn {
  color: white;
  background-color: #618264;
  border-color: transparent;
}

.btn:hover {
  background-color: #79AC78;
}

.create-ad-container {
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
</style>
