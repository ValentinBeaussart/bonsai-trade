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
  <div class="file-upload">
    <b-button class="file-upload-btn" type="button" @click="triggerUpload">Ajouter une image</b-button>
    <div class="image-upload-wrap" ref="uploadWrap" @dragover="addDroppingClass" @dragleave="removeDroppingClass">
      <input class="file-upload-input" ref="fileInput" type='file' @change="readURL" accept="image/*" />
      <div class="drag-text">
        <h3>Drag and drop a file or select add Image</h3>
      </div>
    </div>
    <div class="file-upload-content" ref="fileUploadContent">
      <img class="file-upload-image" :src="imageUrl" alt="your image" />
      <div class="image-title-wrap">
        <button type="button" @click="removeUpload" class="remove-image">Supprimer <span class="image-title">{{ imageName }}</span></button>
      </div>
    </div>
  </div>
    <div class="next-previous-btn mt-4">
  <b-button @click="previousStep" class="step-btn">Retour</b-button>
  <b-button @click="toto" class="step-btn">Valider</b-button>
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
      titi: [],
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
      imageUrl: '',
      imageName: ''
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
    toto () {
      if (this.dropFiles) {
        this.titi.push(this.dropFiles)
      }
    },
    triggerUpload () {
      this.$refs.fileInput.click()
    },
    readURL (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()

        reader.onload = (e) => {
          this.imageUrl = e.target.result
          this.$refs.uploadWrap.style.display = 'none'
          this.$refs.fileUploadContent.style.display = 'block'
          this.imageName = input.files[0].name
        }

        reader.readAsDataURL(input.files[0])
      }
    },
    removeUpload () {
      this.$refs.fileInput.value = ''
      this.imageUrl = ''
      this.$refs.uploadWrap.style.display = 'block'
      this.$refs.fileUploadContent.style.display = 'none'
    },
    addDroppingClass () {
      this.$refs.uploadWrap.classList.add('image-dropping')
    },
    removeDroppingClass () {
      this.$refs.uploadWrap.classList.remove('image-dropping')
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

.file-upload {
  background-color: #ffffff;
  width: 600px;
  margin: 0 auto;
  padding: 20px;
}

.file-upload-btn {
  width: 100%;
  margin: 0;
  color: white;
  background-color: #618264;
  border-color: transparent;
  padding: 10px;
  outline: none;
}

.file-upload-btn:hover {
  background-color: #79AC78;
    color: #ffffff;
  transition: all .2s ease;
  cursor: pointer;
}

.file-upload-btn:active {
  border: 0;
  transition: all .2s ease;
}

.file-upload-content {
  display: none;
  text-align: center;
}

.file-upload-input {
  position: absolute;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  outline: none;
  opacity: 0;
  cursor: pointer;
}

.image-upload-wrap {
  margin-top: 20px;
  border: 4px dashed #618264;
  position: relative;
}

.image-dropping,
.image-upload-wrap:hover {
  background-color: #79AC78;
  border: 4px dashed #ffffff;
}

.image-title-wrap {
  padding: 0 15px 15px 15px;
  color: #222;
}

.drag-text {
  text-align: center;
}

.drag-text h3 {
  font-weight: 100;
  color: #618264;
  padding: 60px 0;
}

.file-upload-image {
  max-height: 200px;
  max-width: 200px;
  margin: auto;
  padding: 20px;
}

.remove-image {
  width: 200px;
  margin: 0;
  color: #fff;
  background: #cd4535;
  border: none;
  padding: 10px;
  border-radius: 4px;
  border-bottom: 4px solid #b02818;
  transition: all .2s ease;
  outline: none;
  text-transform: uppercase;
  font-weight: 700;
}

.remove-image:hover {
  background: #c13b2a;
  color: #ffffff;
  transition: all .2s ease;
  cursor: pointer;
}

.remove-image:active {
  border: 0;
  transition: all .2s ease;
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
