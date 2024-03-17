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
        <b-steps :custom-navigation="true" ref="step" :has-navigation="false"
        class="steps">
        <b-step-item class="step-item" label="Catégorie" icon="bars">
          <b-field label="Sélectionnez une catégorie *">
            <b-select v-model="category" icon="bars">
                <optgroup label="Bonsaï">
                    <option value="Immobilier">Immobilier</option>
                    <option value="prebonsai">Prébonsaï</option>
                    <option value="yamadori">Yamadori</option>
                    <option value="plant_pepiniere">Plant de pépinière</option>
                </optgroup>

                <optgroup label="Poterie">
                    <option value="pot_rond">Pot rond</option>
                    <option value="pot_rectangulaire">Pot rectangulaire</option>
                    <option value="pot_speciaux">Pot spéciaux</option>
                    <option value="pot_mame">Pot mame</option>
                </optgroup>

                <optgroup label="Outillage">
                    <option value="coupe">Coupe</option>
                    <option value="ligaturage">Ligaturage</option>
                    <option value="rempotage">Rempotage</option>
                    <option value="arrosage">Arrosage</option>
                </optgroup>
            </b-select>
        </b-field>
      </b-step-item>

        <b-step-item class="step-item" label="Détails" icon="info">
          <b-field label="Titre *">
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
      category: '',
      name: '',
      description: '',
      price: 0,
      place: '',
      dropFiles: [],
      hasNavigation: false,
      customNavigation: true,
      allFieldsFilled: false,
      currentStep: 1
    }
  },
  created () {
    this.signedIn()
  },
  methods: {
    confirmCustom () {
      this.$buefy.dialog.confirm({
        title: 'Règles',
        message: `Bonsai Trade est un site de Petites Annonces dédié au monde du bonsaï. Il est réservé à la vente, à l’échange ou à la recherche d’objet lié au monde du bonsaï. Les annonces paraissent automatiquement et resteront en ligne (sans intervention de l’annonceur) durant 60 jours.
Bonsai Trade se réserve le droit de supprimer sans préavis toute annonce qui ne correspondrait pas à l’objet du site. Les objets contrefaits, les médias piratés, seront supprimés du site. De même, les publicités déguisées en annonce seront systématiquement supprimées.
Bonsai Trade est un service mis à disposition des annonceurs mais ne certifie pas l’exactitude des informations publiées dans le cadre d’une annonce. Celle-ci n’engage que la seule responsabilité de l’annonceur. Bonsai Trade ne pourra être tenu responsable de litige pouvant intervenir entre les utilisateurs de son service de Petites Annonces.`,
        confirmText: 'Accepter',
        type: 'is-success'
      })
    },
    checkFields () {
      if (this.currentStep === 1) {
        this.allFieldsFilled = this.category !== ''
      } else if (this.currentStep === 2) {
        this.allFieldsFilled =
          this.name !== '' &&
          this.description !== '' &&
          this.price !== 0 &&
          this.place !== '' &&
          this.dropFiles.length > 0
      }
    },

    deleteDropFile (index) {
      this.dropFiles.splice(index, 1)
    },

    signedIn () {
      return localStorage.signedIn
    },

    success () {
      this.$buefy.toast.open({
        message: 'Votre annonce a été créée avec succès',
        type: 'is-success'
      })
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
    }
  },
  watch: {
    category (newValue, oldValue) {
      this.checkFields()
    },
    name (newValue, oldValue) {
      this.checkFields()
    },
    description (newValue, oldValue) {
      this.checkFields()
    },
    price (newValue, oldValue) {
      this.checkFields()
    },
    place (newValue, oldValue) {
      this.checkFields()
    },
    dropFiles (newValue, oldValue) {
      this.checkFields()
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

.steps-container {
  margin-top: 50px;
}

.step-item {
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
  margin-bottom: 0;
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

.politics-btn {
  margin-top: 20px;
  width: 20%;
  color: white;
  background-color: #618264;
}

.politics-btn:hover {
  background-color: #79AC78;
}

.next-previous-step-btn {
  width: 10%;
  color: white;
  background-color: #618264;
}

.next-previous-step-btn:hover {
  background-color: #79AC78;
}

.btn-next-step-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 60%;
  margin: 100px auto;
  margin-top: 20px;
}

.input-info {
  width: 500px;
}
</style>
