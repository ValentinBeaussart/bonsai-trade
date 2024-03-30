<template lang="">
  <div class="profile-container">
    <div class="left-column">
      <h2>Mes annonces</h2>
    </div>
    <div class="right-column">
      <h2>Profile</h2>
      <p>{{ current_user.email }}</p>
    </div>
  </div>
</template>

<style scoped>
.profile-container {
  display: flex;
  justify-content: space-between;
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
