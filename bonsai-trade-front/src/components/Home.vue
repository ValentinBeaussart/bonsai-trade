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
        </b-field>
        </div>
        <div v-if="ads.length === 0" class="no-result-message">
        Aucun résultat trouvé pour "{{ search }}"
      </div>
      <div class="card-container">
        <router-link style="text-decoration:none" to="'/ad/'">
        <b-card  v-for="ad in ads" :key="ad.id" :ad="ad" no-body class="overflow-hidden mt-3" style="width: 540px;">
    <b-row no-gutters>
      <b-col md="6">
        <b-card-img src="https://picsum.photos/400/400/?image=20" alt="Image" class="rounded-0"></b-card-img>
      </b-col>
      <b-col md="6">
        <b-card-body :title="ad.name">
          <b-card-text>
           {{ ad.description }}
          </b-card-text>
          <div class="infos">
            <div class="price">
              <i class="bi bi-currency-euro"></i>
              {{ ad.price }}
            </div>
            <div class="location">
              <i class="bi bi-geo-alt"></i>
              {{ ad.place }}
            </div>
            <div class="user">
              <i class="bi bi-person"></i>
                            {{ ad.user.username }}
            </div>
            <div class="category">
              <i class="bi bi-list"></i>
                            {{ ad.category.name }}
            </div>
            <div class="date">
              <i class="bi bi-calendar"></i>
                            {{ ad.created_at }}
            </div>
          </div>
        </b-card-body>
      </b-col>
    </b-row>
  </b-card>
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

.card-container {
  display: grid;
  justify-content: center;
  margin-top: 50px;
  width: 100%;
}

.no-result-message {
  text-align: center;
  margin-top: 80px;
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
</style>
