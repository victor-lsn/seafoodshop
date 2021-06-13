<template>
  <div style="font-size: 22px;font-weight: bold">
    <div style="display: flex;justify-content: space-between">
      <span>欢迎来到后台管理系统</span>
      <div>
        <span style="font-size: 18px">当前年份：</span>
        <el-date-picker @change="changeYear" v-model="year" type="year" placeholder="选择年"></el-date-picker>
      </div>
    </div>
    <div style="margin-top: 8px">
      <div class="my_font">今日订单：<p style="color:#C23531">{{dayCount}}</p></div>
      <div class="my_font">今年订单：<p style="color:#C23531">{{yearCount}}</p></div>
    </div>

    <div style="display: flex;justify-content: space-around;margin-top: 20px">
      <!-- [1] 为 ECharts 准备一个具备大小 (宽高) 的 DOM 标签-->
      <div id="chart1" ref="chart1" style="width: 380px; height: 350px"></div>
      <div id="chart2" ref="chart2" style="width: 560px; height: 350px"></div>
      <div id="chart3" ref="chart3" style="width: 380px; height: 350px"></div>
    </div>
  </div>
</template>

<script>
import echarts from 'echarts';
import * as statistics from '../../../network/admin/menu/menu'

// 按需引入
// import echarts from 'echarts/lib/echarts'; // 引入基本模板
// import bar from 'echarts/lib/chart/bar';   // 引入柱状图组件

export default {
  data() {
    return {
      chart: null,
      orderCountList: [],
      orderMoneyList: [],
      saleCountCategoryList: [],
      saleCountCategory: [],
      dayCount:null,
      yearCount:null,
      year:"2021"
    };
  },
  mounted() {

    this.getOrderCountByMonth();
    this.getOrderMoneyByMonth();
    // [3] 基于准备好的 DOM，初始化 Echarts 实例
    // 使用 ref 访问 DOM, 也可以使用 document.getElementById('chart')
    // [4] 设置 Echarts 图表数据
    this.getSaleCountByCategory();
    this.getOrderCountMap();
  },
  methods: {
    changeYear(){
      this.getOrderCountByMonth();
      this.getOrderMoneyByMonth();
      this.getOrderCountMap();
    },
    makeChart1(chart) {
      chart.setOption({
        //设置标题
        title: {
          text: '年订单(个)'
        },
        tooltip: {},
        //设置x轴的内容
        xAxis: {
          data: ["1", "2", "3", "4", "5", "6", "7", "9", "10", "11", "12"]
        },
        //设置y轴的内容
        yAxis: {},
        //设置数据信息
        series: [{
          name: '销量',
          type: 'bar',
          data: this.orderCountList
        }]
      });
    },
    makeChart2(chart) {
      chart.setOption({
        //设置标题
        title: {
          text: '年营业额(元)'
        },
        tooltip: {
          trigger: 'axis'
        },
        //设置x轴的内容
        xAxis: {
          data: ["1", "2", "3", "4", "5", "6", "7", "9", "10", "11", "12"]
        },
        //设置y轴的内容
        yAxis: {},
        //设置数据信息
        series: [{
          name: '营业额',
          type: 'line',
          data: this.orderMoneyList
        }]
      });
    },
    makeChart3(chart) {
      chart.setOption({
        //设置标题
        title: {
          text: '分类销量(个)'
        },
        tooltip: {},
        legend: {//图例  标注各种颜色代表的模块
          bottom: 10,//控制图例出现的距离  默认左上角
          left: 'center',//控制图例的位置
          itemWidth: 16,//图例颜色块的宽度和高度
          itemHeight: 12,
          textStyle: {//图例中文字的样式
            color: '#000',
            fontSize: 11
          },
          data: this.saleCountCategoryList//图例上显示的饼图各模块上的名字
        },
        //设置数据信息
        series: [{
          name: '销量',
          type: 'pie',
          data: this.saleCountCategory,
          itemStyle: {
            normal: {
              label: {
                show: false,//饼图上是否出现标注文字 标注各模块代表什么  默认是true
                // position: 'inner',//控制饼图上标注文字相对于饼图的位置  默认位置在饼图外
              },
              labelLine: {
                show: false//官网demo里外部标注上的小细线的显示隐藏    默认显示
              }
            }
          }
        }]
      });
    },
    getOrderCountByMonth() {
      statistics.getOrderCountByMonth2(new Date(this.year).getFullYear()).then(res => {
        this.orderCountList = Object.values(res.data.data);
        this.chart1 = echarts.init(this.$refs.chart1);
        this.makeChart1(this.chart1);
      })
    },
    getOrderMoneyByMonth() {
      statistics.getOrderMoneyByMonth2(new Date(this.year).getFullYear()).then(res => {
        this.orderMoneyList = Object.values(res.data.data);
        this.chart2 = echarts.init(this.$refs.chart2);
        this.makeChart2(this.chart2);
      })
    },
    getSaleCountByCategory() {
      statistics.getSaleCountByCategory().then(res => {
        this.saleCountCategoryList = Object.keys(res.data.data);
        let keys = Object.keys(res.data.data);
        let values = Object.values(res.data.data);
        console.log(keys);
        console.log(values);
        for (let i = 0; i < keys.length; i++) {
          this.saleCountCategory.push({
            "name":keys[i],
            "value":values[i],
          });
        }
        console.log(this.saleCountCategory)
        this.chart3 = echarts.init(this.$refs.chart3);
        this.makeChart3(this.chart3);
      })
    },
    getOrderCountMap(){
      statistics.getOrderCountMap2(new Date(this.year).getFullYear()).then(res=>{
        this.dayCount = res.data.data.dayCount;
        this.yearCount = res.data.data.yearCount;
      })
    }
  }
};
</script>

<style scoped>
.my_font {
  font-size: 15px;
  display: flex;
  align-items: center;
}
</style>
