<template lang="">
  <div class="profile-container">
    <div class="left-column">
      <h2>Mes annonces</h2>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>
      <p>Contenu supplémentaire pour Mes annonces.</p>

      <p>Encore du contenu supplémentaire pour Mes annonces.</p>
    </div>
    <div class="right-column">
      <h2>Mes informations</h2>
      <i class="bi bi-person"></i>
      <br>
      <i class="bi bi-envelope"></i>
      <h2>Profile</h2>

    </div>
  </div>
</template>

<style scoped>
.profile-container {
  display: flex;
  align-items: flex-start; /* Permet des hauteurs différentes */
  width: 80%;
  margin: 100px auto;
}

.left-column,
.right-column {
  flex: 1;
  background-color: white;
  padding: 20px;
  border-radius: 5px;
  border: 1px solid #ddd;
}

.right-column {
  margin-left: 20px;
}

.left-column {
  flex: 2;
}
</style>
