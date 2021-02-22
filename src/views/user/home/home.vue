<template>
  <div class="container">
    <div class="myheader">
      <home-tab-bar></home-tab-bar>
    </div>
  </div>
</template>

<script>
import tabbar from "@/components/user/tabbar";
export default {
  name: "home",
  components:{
    "home-tab-bar":tabbar
  },
  data() {
    return {}
  }
}
</script>

<style scoped>
.container{
  display: flex;
  flex-direction: column;
}
.myheader{
  display: flex;
  width: 100%;
}
</style>
