<template lang="">
  <nav>
    <div class="wrapper">
      <div class="logo"><router-link to="/home">Accueil</router-link></div>
      <input type="radio" name="slider" id="menu-btn">
      <input type="radio" name="slider" id="close-btn">
      <ul class="nav-links">
        <label for="close-btn" class="btn close-btn"><i class="fas fa-times"></i></label>
        <li><router-link to="/home">Annonces</router-link></li>
        <li>
          <a class="desktop-item">Catégories</a>
          <input type="checkbox" id="showMega">
          <label for="showMega" class="mobile-item">Mega Menu</label>
          <div class="mega-box">
            <div class="content">
              <div class="row">
                <img src="../assets/bonsai-catégories.jpg" alt="">
              </div>
              <div class="row">
                <header>Bonsaï</header>
                <ul class="mega-links">
                  <li><a href="#">Bonsaï</a></li>
                  <li><a href="#">Prébonsaï</a></li>
                  <li><a href="#">Yamadori</a></li>
                  <li><a href="#">Plant de pépinière</a></li>
                </ul>
              </div>
              <div class="row">
                <header>Poterie</header>
                <ul class="mega-links">
                  <li><a href="#">Pot rond</a></li>
                  <li><a href="#">Pot rectangulaire</a></li>
                  <li><a href="#">Pot spéciaux</a></li>
                  <li><a href="#">Pot mame</a></li>
                </ul>
              </div>
              <div class="row">
                <header>Outillage</header>
                <ul class="mega-links">
                  <li><a href="#">Coupe</a></li>
                  <li><a href="#">Ligaturage</a></li>
                  <li><a href="#">Rempotage</a></li>
                  <li><a href="#">Arrosage</a></li>
                </ul>
              </div>
            </div>
          </div>
        </li>
        <li><router-link to="/createad">Publier une annonce</router-link></li>
        <li><router-link to="/signin" v-if="!signedIn()">Connexion</router-link></li>
        <li class="sign-out-sign-up-link"><router-link to="/signup" v-if="!signedIn()">S'inscrire</router-link></li>
        <li><router-link to="/profile" v-if="signedIn()">Profile</router-link></li>
        <li class="sign-out-sign-up-link" @click="signOut"><router-link to="/home" v-if="signedIn()">Déconnexion</router-link></li>
      </ul>
      <label for="menu-btn" class="btn menu-btn"><i class="fas fa-bars"></i></label>
    </div>
  </nav>
  </template>
<script>
export default {
  name: 'Navbar',
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          window.location.reload()
        })
        .catch(error => this.setError(error, 'Un problème empêche la déconnexion'))
    }
  }
}
</script>
<style scoped lang="">
  @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
  *{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
  }

  .sign-out-sign-up-link a{
    background-color: #79AC78!important;
  }

  nav{
    z-index: 9999;
    width: 100%;
    background: #618264;
  }
  nav .wrapper{
    position: relative;
    max-width: 1300px;
    padding: 0px 30px;
    height: 70px;
    line-height: 70px;
    margin: auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .wrapper .logo a{
    color: #f2f2f2;
    font-size: 30px;
    font-weight: 600;
    text-decoration: none;
  }
  .wrapper .nav-links{
    display: inline-flex;
  }
  .nav-links li{
    list-style: none;
  }
  .nav-links li a{
    color: #f2f2f2;
    text-decoration: none;
    font-size: 18px;
    font-weight: 500;
    padding: 9px 15px;
    border-radius: 5px;
    transition: all 0.3s ease;
  }
  .nav-links li a:hover{
    background: #79AC78;
  }
  .nav-links .mobile-item{
    display: none;
  }
  .nav-links .drop-menu{
    position: absolute;
    background: #618264;
    width: 180px;
    line-height: 45px;
    top: 85px;
    opacity: 0;
    visibility: hidden;
    box-shadow: 0 6px 10px rgba(0,0,0,0.15);
  }
  .nav-links li:hover .drop-menu,
  .nav-links li:hover .mega-box{
    transition: all 0.3s ease;
    top: 70px;
    opacity: 1;
    visibility: visible;
  }

  .mega-box{
    z-index: 999;
    position: absolute;
    left: 0;
    width: 100%;
    padding: 0 30px;
    top: 85px;
    opacity: 0;
    visibility: hidden;
  }
  .mega-box .content{
    background: #618264;
    padding: 25px 20px;
    display: flex;
    width: 100%;
    justify-content: space-between;
  }
  .mega-box .content .row{
    width: calc(25% - 30px);
    line-height: 45px;
  }
  .content .row img{
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  .content .row header{
    color: #f2f2f2;
    font-size: 20px;
    font-weight: 500;
  }
  .content .row .mega-links{
    margin-left: -40px;
    border-left: 1px solid rgba(255,255,255,0.09);
  }
  .row .mega-links li{
    padding: 0 20px;
  }
  .row .mega-links li a{
    padding: 0px;
    padding: 0 20px;
    color: #d9d9d9;
    font-size: 17px;
    display: block;
  }
  .row .mega-links li a:hover{
    color: #f2f2f2;
  }
  .wrapper .btn{
    color: #fff;
    font-size: 20px;
    cursor: pointer;
    display: none;
  }
  .wrapper .btn.close-btn{
    position: absolute;
    right: 30px;
    top: 10px;
  }

  @media screen and (max-width: 970px) {
    .wrapper .btn{
      display: block;
    }
    .wrapper .nav-links{
      position: fixed;
      height: 100vh;
      width: 100%;
      max-width: 350px;
      top: 0;
      left: -100%;
      background: #242526;
      display: block;
      padding: 50px 10px;
      line-height: 50px;
      overflow-y: auto;
      box-shadow: 0px 15px 15px rgba(0,0,0,0.18);
      transition: all 0.3s ease;
    }
    ::-webkit-scrollbar {
      width: 10px;
    }
    ::-webkit-scrollbar-track {
      background: #242526;
    }
    ::-webkit-scrollbar-thumb {
      background: #3A3B3C;
    }
    #menu-btn:checked ~ .nav-links{
      left: 0%;
    }
    #menu-btn:checked ~ .btn.menu-btn{
      display: none;
    }
    #close-btn:checked ~ .btn.menu-btn{
      display: block;
    }
    .nav-links li{
      margin: 15px 10px;
    }
    .nav-links li a{
      padding: 0 20px;
      display: block;
      font-size: 20px;
    }
    .nav-links .drop-menu{
      position: static;
      opacity: 1;
      top: 65px;
      visibility: visible;
      padding-left: 20px;
      width: 100%;
      max-height: 0px;
      overflow: hidden;
      box-shadow: none;
      transition: all 0.3s ease;
    }
    #showDrop:checked ~ .drop-menu,
    #showMega:checked ~ .mega-box{
      max-height: 100%;
    }
    .nav-links .desktop-item{
      display: none;
    }
    .nav-links .mobile-item{
      display: block;
      color: #f2f2f2;
      font-size: 20px;
      font-weight: 500;
      padding-left: 20px;
      cursor: pointer;
      border-radius: 5px;
      transition: all 0.3s ease;
    }
    .nav-links .mobile-item:hover{
      background: #3A3B3C;
    }
    .drop-menu li{
      margin: 0;
    }
    .drop-menu li a{
      border-radius: 5px;
      font-size: 18px;
    }
    .mega-box{
      position: static;
      top: 65px;
      opacity: 1;
      visibility: visible;
      padding: 0 20px;
      max-height: 0px;
      overflow: hidden;
      transition: all 0.3s ease;
    }
    .mega-box .content{
      box-shadow: none;
      flex-direction: column;
      padding: 20px 20px 0 20px;
    }
    .mega-box .content .row{
      width: 100%;
      margin-bottom: 15px;
      border-top: 1px solid rgba(255,255,255,0.08);
    }
    .mega-box .content .row:nth-child(1),
    .mega-box .content .row:nth-child(2){
      border-top: 0px;
    }
    .content .row .mega-links{
      border-left: 0px;
      padding-left: 15px;
    }
    .row .mega-links li{
      margin: 0;
    }
    .content .row header{
      font-size: 19px;
    }
  }
  nav input{
    display: none;
  }

  .body-text{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 100%;
    text-align: center;
    padding: 0 30px;
  }
  .body-text div{
    font-size: 45px;
    font-weight: 600;
  }
  </style>
