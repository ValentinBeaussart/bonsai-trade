
<template lang="">
  <div>
    <div class="search-bar-container">
    <b-field class="search-bar">
            <b-input class="search" placeholder="Azalée..."
                type="search" v-model="search"
                icon-right="close-circle"
                icon-right-clickable
                @icon-right-click="clearIconClick"
                @input="searchAds">
            </b-input>
            <b-button
            class="search-btn"
                icon-right="search" @click="searchAds" />
        </b-field>
        </div>
        <div v-if="ads.length === 0" class="no-result-message">
        Aucun résultat trouvé pour "{{ search }}"
      </div>
        <div class="cards-container">
        <div v-for="ad in ads" :key="ad.id" :ad="ad">
          <router-link to="/signin">
        <div class="card">
  <div class="photo">
    <img src="../assets/bonsai-catégories.jpg">
  </div>
  <div class="price-box">
    <p>{{ ad.price }} €</p>
  </div>
  <div class="description">
  <h2>{{ ad.name }} ({{ ad.latin_name }})</h2>
  <div class="info">
    <b-icon pack="fas" icon="bars" size="is-small"></b-icon>
      <p>{{ ad.category.name }}</p>
      <b-icon pack="fas" icon="user" size="is-small"></b-icon>
      <p>{{ ad.user.username }}</p>
      <b-icon pack="fas" icon="home" size="is-small"></b-icon>
      <p>{{ ad.place }}</p>
      <b-icon pack="fas" icon="clock" size="is-small"></b-icon>
      <p>{{ ad.created_at }}</p>
    </div>
    <p class="ads-description">{{ ad.description }}</p>
  </div>
</div>

</router-link>
</div>
<!-- <b-pagination
      v-model="currentPage"
      :total="totalPages"
      @input="changePage"
      :aria-next-label="nextLabel"
      :aria-previous-label="prevLabel"
    ></b-pagination> -->
</div>

  </div>
</template>

<script>
export default {
  name: 'Home',
  data () {
    return {
      ads: [],
      search: '',
      currentPage: 1,
      pageSize: 5
    }
  },
  created () {
    this.fetchAds()
  },
  methods: {
    fetchAds () {
      this.$http.secured.get('/api/v1/ads')
        .then(response => {
          this.ads = response.data.ads
          console.log('ads:', this.ads)
          this.totalPages = response.data.total
          console.log('totalPages:', this.totalPages)
        })
        .catch(error => {
          console.error('Error fetching ads:', error)
        })
    },
    searchAds () {
      this.$http.secured.get('/api/v1/ads?search=' + this.search)
        .then(response => {
          this.ads = response.data.ads
        })
        .catch(error => {
          console.error('Error fetching ads:', error)
        })
    },
    clearIconClick () {
      this.search = ''
      this.loadAllAds()
    },
    loadAllAds () {
      this.fetchAds()
    }
  }
}
</script>

<style scoped lang="">
.no-result-message {
  text-align: center;
  margin-top: 80px;
}

.search-btn {
  background-color: #79AC78;
  color: white;
  border-radius: 0 5px 5px 0;
}

.search-bar-container {
  display: flex;
  justify-content: center;
  margin-top: 50px;
}

.search-bar {
  display: flex;
  justify-content: center;
}

.search-bar .search {
  width: 400px;
}

.cards-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 50px;
  width: 100%;
  min-height: 500px;
}

.ads-description {
  margin-top: 10px;
  margin-right: 20px;
}

.description {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
}

.info {
  margin-top: 10px;
  display: flex;
  align-items: center;
}

.info b-icon,
.info p {
  margin-right: 10px;
}

.info p {
  margin-left: 5px;
}

.info b-icon:last-child,
.info p:last-child {
  margin-right: 0;
}

.description h2 {
  margin: 0;
  font-size: 1.5em;
}

.price-box {
  position: absolute;
  top: 0;
  right: 0;
  width: 150px;
  height: 70px;
  background-color: #79AC78;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 0 0 0 5px;
}

.price-box p {
  margin: 0;
  color: white;
  font-weight: bold;
}

.card {
  cursor: pointer;
  width: 800px;
  height: auto;
  background: white;
  margin-bottom: 20px;
  box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
  transition: all 0.3s;
  overflow: hidden;
}

.card:hover {
  box-shadow: 0 8px 17px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.photo {
  width: 30%;
  max-width: 205px;
  text-align: center;
  float: left;
  overflow: hidden;
  margin-right: 20px;
}

.photo img {
  max-width: 100%;
  height: auto;
}

@media (max-width: 768px) {
  .card {
    width: 100%;
  }
}
</style>
