<template>
  <div class="mybottom">
    <el-divider></el-divider>
    <div class="content_body_box">
      <!--    海惠派新    -->
      <div style="display: flex;justify-content: space-between;width: 100%">
        <div style="display: flex;justify-content: center;align-items: center">
          <img class="img_bottom" src="../../assets/hai.png"/>
          <div class="font_bottom">真海捕捞</div>
        </div>
        <div style="display: flex;justify-content: center;align-items: center">
          <img class="img_bottom" src="../../assets/hui.png"/>
          <div class="font_bottom">价格实惠</div>
        </div>
        <div style="display: flex;justify-content: center;align-items: center">
          <img class="img_bottom" src="../../assets/pai.png"/>
          <div class="font_bottom">线下派送</div>
        </div>
        <div style="display: flex;justify-content: center;align-items: center">
          <img class="img_bottom" src="../../assets/xin.png"/>
          <div class="font_bottom">绝对新鲜</div>
        </div>
      </div>
      <!--     友情链接等     -->
      <div style="display: flex;justify-content: space-between;width: 100%;margin-top: 15px;align-items: center">
        <div>
          <div class="bottome_font">关于我们 | 联系我们 | 合作招商 | 商家帮助 | 营销中心 | 友情链接 | 销售联盟 | 海鲜社区</div>
          <div class="bottome_font">风险检测 | 隐私政策 | 海鲜公益 | English Site | Media & IR</div>
          <div class="bottome_font">京公网安备 11000002000088号 | 京ICP备11041704号 | 互联网药品信息服务资格证编号(京)-经营性-2014-0008</div>
          <div class="bottome_font">互联网出版许可证编号新出网证(京)字150号 | 新出发京零 字第大120007号 | 出版物经营许可证</div>
          <div class="bottome_font">违法和不良信息举报电话：4006561155 | 消费者维权热线：4006067733 | 经营证照 | (京)网械平台备字(2018)第00003号
          </div>
          <div class="bottome_font">营业执照 | Global Site | Сайт России | Situs Indonesia | Sitio de España |
            เว็บไซต์ประเทศไทย
          </div>
        </div>
        <el-card style="width: 190px;height: 190px;display: flex;justify-content: center;align-items: center">
          <img class="img_bottom" src="../../assets/me.jpg" style="height: 180px;width: 180px"/>
        </el-card>
      </div>
      <div style="display: flex;justify-content: center;width: 100%;margin-top: 20px;align-items: center">
        <img class="img_bottom" src="../../assets/police.png" style="width:700px;object-fit: cover"/>
      </div>
    </div>
  </div>
</template>

<script>
export default {
name: "mybottom"
}
</script>

<style scoped>
.mybottom {
  width: 100%;
  height: 400px;
  display: flex;
  align-items: center;
  flex-direction: column;
}

.img_bottom {
  width: 42px;
  height: 42px;
  margin-right: 5px;
}

.font_bottom {
  font-size: 22px;
  font-weight: 200;
  color: #D81E06;
  font-family: 华文琥珀
}

.bottome_font {
  font-size: 14px;
  margin: 10px 0;
  color: #999999;
}

.content_body_box {
  width: 66%;
  display: flex;
  align-items: center;
  flex-direction: column;
  justify-content: center
}
</style>
