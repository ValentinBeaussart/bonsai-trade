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
          <h4 class="mb-4">Catégorie</h4>
          <b-form-select style="width: 40%" v-model="category" class="m-2 mb-4" required>
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
<b-alert v-if="categoryError" show variant="danger">Veuillez sélectionner une catégorie.</b-alert>
<div class="next-btn">
<b-button @click="nextStep" class="step-btn mt-4">Suivant</b-button>
</div>
</div>
<div v-if="currentStep === 2" class="create-ad-container">
  <h2 class="mb-5">Publier votre annonce</h2>
  <h4 class="mb-4">Informations</h4>
  <b-form-group label="Titre" class="mt-4" :state="nameState">
  <b-form-input v-model="name" placeholder="Azalée Satsuki" :state="nameState"></b-form-input>
  <div v-if="nameError" class="text-danger">Veuillez ajouter un titre à votre annonce.</div>
</b-form-group>
<b-form-group label="Prix" class="mt-4" :state="priceState">
  <b-form-input v-model="price" placeholder="500" type="number" :state="priceState"></b-form-input>
  <div v-if="priceError" class="text-danger">Veuillez ajouter un prix à votre annonce.</div>
</b-form-group>
<b-form-group label="Localisation" class="mt-4" :state="placeState">
  <b-form-input v-model="place" placeholder="Lyon" :state="placeState"></b-form-input>
  <div v-if="placeError" class="text-danger">Veuillez ajouter une localisation à votre annonce.</div>
</b-form-group>
<b-form-group label="Description" class="mt-4" :state="descriptionState">
  <b-form-textarea v-model="description" placeholder="Magnifique azalée, cultivée depuis 20 ans. Floraison estivale blanche. À venir récupérer sur Lyon, prix négociable." rows="3" max-rows="6" :state="descriptionState"></b-form-textarea>
  <div v-if="descriptionError" class="text-danger">Veuillez ajouter une description à votre annonce.</div>
</b-form-group>
  <div class="next-previous-btn mt-4">
  <b-button @click="previousStep" class="step-btn">Retour</b-button>
  <b-button @click="nextStep2" class="step-btn">Suivant</b-button>
  </div>
</div>
<div v-if="currentStep === 3" class="create-ad-container">
  <h2 class="mb-5">Publier votre annonce</h2>
  <h4 class="mb-4">Images</h4>
  <b-form-group>
    <b-form-file v-model="dropFiles" accept=".jpg, .png, .jpeg" id="file-default" browseText="Ajouter" placeholder="Aucun fichier sélectionné"></b-form-file>
  </b-form-group>
  <b-button @click="addImage" class="step-btn">Ajouter</b-button>
<div class="d-flex flex-wrap mt-5">
  <b-badge v-for="file in images" :key="file.name" class="mr-2 mb-2 badge">
    {{ file.name }}
    <span @click="removeImage(file)" class="ml-2" style="cursor: pointer;">&times;</span>
  </b-badge>
</div>
<div class="d-flex flex-wrap mt-2">
  <img v-for="file in images" :key="file.name" :src="createObjectURL(file)" class="mr-2 mb-2" style="width: 100px; height: 100px;">
</div>
<div v-if="showImagesAlert" class="mt-3">
  <b-alert variant="danger" show>
    5 images maximum par annonce.
  </b-alert>
</div>
<div class="next-previous-btn mt-4">
  <b-button @click="previousStep" class="step-btn">Retour</b-button>
  <b-button @click="createAd" class="step-btn">Valider</b-button>
  </div>
  </div>
</div>
</div>
</template>

<script>
export default {
  name: 'CreateAd',
  data () {
    return {
      category: null,
      name: null,
      description: null,
      price: null,
      place: null,
      dropFiles: null,
      images: [],
      currentStep: 1,
      categoryError: false,
      nameState: null,
      placeState: null,
      priceState: null,
      descriptionState: null,
      nameError: false,
      descriptionError: false,
      priceError: false,
      placeError: false,
      showImagesAlert: false
    }
  },
  created () {
    this.signedIn()
  },
  methods: {
    signedIn () {
      return localStorage.signedIn
    },
    createObjectURL (file) {
      return window.URL.createObjectURL(file)
    },
    createAd () {
      this.$http.secured.post('/api/v1/ads/', { name: this.name, category_name: this.category, description: this.description, price: this.price, place: this.place })
        .then(() => {
          this.success()
          setTimeout(() => {
            window.location.reload()
          }, 1500)
        })
        .catch()
    },
    nextStep2 () {
      this.nameState = !!this.name
      this.placeState = !!this.place
      this.priceState = !!this.price
      this.descriptionState = !!this.description

      this.nameError = !this.name
      this.placeError = !this.place
      this.priceError = !this.price
      this.descriptionError = !this.description

      if (!this.name || !this.description || !this.place || !this.price) {
        return
      }
      this.currentStep++
    },
    nextStep () {
      if (!this.category) {
        this.categoryError = true
        return
      }
      this.currentStep++
      this.categoryError = false
    },
    previousStep () {
      this.currentStep--
    },
    addImage () {
      if (this.dropFiles && this.images.length < 5) {
        this.images.push(this.dropFiles)
        this.dropFiles = null
      } else {
        this.showImagesAlert = true
      }
    },
    removeImage (fileToRemove) {
      this.images = this.images.filter(file => file !== fileToRemove)
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

.badge {
  background-color: #618264;
}

.form-group {
  width: 100%;
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

.step-btn {
  width: 20%;
  color: white;
  background-color: #618264;
  border-color: transparent;
}

.step-btn:hover {
  background-color: #79AC78;
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

.next-previous-btn {
  display: flex;
  justify-content: space-between;
  width: 100%;
}

.next-btn {
  display: flex;
  justify-content: flex-end;
  width: 100%;
}
</style>
