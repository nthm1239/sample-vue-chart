<template>
  <div class="chart">
      <v-container>
          <v-row>
              <v-col cols="12">
                <v-toolbar flat color="white">
                    <v-btn-toggle
                        v-model="selectedChartType"
                        mandatory>
                        <v-btn outlined color="grey darken-2">
                            チャート
                        </v-btn>
                        <v-btn outlined color="grey darken-2">
                            集計
                        </v-btn>
                    </v-btn-toggle>
                </v-toolbar>


                <div v-show="selectedChartType === 0">
                    <v-toolbar flat color="white">
                        <v-btn-toggle
                            v-model="selectedTransitionType"
                            mandatory>
                            <v-btn outlined color="grey darken-2">
                                1日
                            </v-btn>
                            <v-btn outlined color="grey darken-2">
                                7日
                            </v-btn>
                            <v-btn outlined color="grey darken-2">
                                30日
                            </v-btn>
                        </v-btn-toggle>
                    </v-toolbar>

                    <LineChart 
                        :chart-data="datacollection.chartData" 
                        :options="datacollection.chartOptions"
                        :height="height"
                        :width="width"               
                    />
                </div>
                <div v-show="selectedChartType === 1">
                    <v-toolbar flat color="white">
                        <v-btn-toggle
                            v-model="selectedTotalingType"
                            mandatory>
                            <v-btn outlined color="grey darken-2">
                                月
                            </v-btn>
                            <v-btn outlined color="grey darken-2">
                                曜日
                            </v-btn>
                            <v-btn outlined color="grey darken-2">
                                時間帯
                            </v-btn>
                        </v-btn-toggle>
                    </v-toolbar>

                    <Bar 
                        :chart-data="datacollection.chartData" 
                        :options="datacollection.chartOptions"
                        :height="height"
                        :width="width"               
                    />
                </div>
              </v-col>
          </v-row>
      </v-container>
  </div>
</template>

<script>
  import LineChart from '../components/LineChart'
  import Bar from '../components/Bar'

  export default {
    name: 'Chart',
    data: () => ({
      datacollection: {
          chartData: null,
          chartOptions: null,
      },
      height: window.innerHeight * 0.8,
      width: window.innerWidth * 0.8,
      selectedChartType: 0,
      selectedTotalingType: 0,
      selectedTransitionType: 0,
      date: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
    }),
    mounted () {
      this.fillDataTotalingMonthly()
    },
    methods: {
        fillDataTotalingMonthly() {
            this.datacollection = {
                chartData : {
                    labels: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
                    datasets: [
                        {
                            label: '集計：月',
                            data: [28, 20, 30, 40, 50, 40, 33, 45, 20, 21, 33, 59],
                            fill: false,
                            // borderWidth: 1
                        }
                    ]
                },
                chartOptions: this.defaultLineChartOption()
            }
        },
        fillDataTotalingDayofWeek() {
            this.datacollection = {
                chartData : {
                    labels: ['日', '月', '火', '水', '木', '金', '土'],
                    datasets: [
                        {
                            label: '集計：曜日',
                            data: [0, 28, 20, 30, 40, 50, 0],
                            fill: false,
                            // borderWidth: 1
                        }
                    ]
                },
                chartOptions: this.defaultLineChartOption()
            }
        },
        fillDataTotalingTimezone() {
            this.datacollection = {
                chartData : {
                    labels: ['0時', '1時', '2時', '3時', '4時', '5時', '6時', '7時', '8時', '9時', '10時', '11時', '12時', '13時', '14時', '15時', '16時', '17時', '18時', '19時', '20時', '21時', '22時', '23時'],
                    datasets: [
                        {
                            label: '集計：時間帯',
                            data: [0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 3, 4, 10, 4, 5, 1, 1, 7, 3, 1, 0, 0, 0, 0].map((element) => element * 7),
                            fill: false,
                            // borderWidth: 1
                        }
                    ]
                },
                chartOptions: this.defaultLineChartOption()
            }
        },
        fillDataTransitionDaily() {
            this.datacollection = {
                chartData : {
                    labels: ['0時', '1時', '2時', '3時', '4時', '5時', '6時', '7時', '8時', '9時', '10時', '11時', '12時', '13時', '14時', '15時', '16時', '17時', '18時', '19時', '20時', '21時', '22時', '23時'],
                    datasets: [
                        {
                            label: '推移：1日',
                            data: [0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 3, 4, 10, 4, 5, 1, 1, 7, 3, 1, 0, 0, 0, 0].map((element) => element * 2),
                            fill: false,
                            // borderWidth: 1
                        }
                    ]
                },
                chartOptions: this.defaultLineChartOption()
            }
        },
        fillDataTransition7days() {
            this.datacollection = {
                chartData : {
                    labels: this.getDayArray(new Date(), 7),
                    datasets: [
                        {
                            label: '推移：7日',
                            data: [28, 20, 0, 0, 50, 14, 32],
                            fill: false,
                            // borderWidth: 1
                        }
                    ]
                },
                chartOptions: this.defaultLineChartOption()
            }
        },
        fillDataTransition30days() {
            this.datacollection = {
                chartData : {
                    labels: this.getDayArray(new Date(), 30),
                    datasets: [
                        {
                            label: '推移：30日',
                            data: [15, 22, 8, 6, 0, 0, 10, 7, 22, 13, 20, 0, 0, 31, 5, 20, 11, 3, 0, 0, 11, 29, 15, 28, 20, 0, 0, 50, 14, 32],
                            fill: false,
                            // borderWidth: 1
                        }
                    ]
                },
                chartOptions: this.defaultLineChartOption()
            }
        },
        defaultLineChartOption() {
            return {
                    plugins: {
                        colorschemes: {
                            scheme: 'tableau.Tableau20',
                        },
                    },
                    legend: {
                        display: false
                    },
                    title: {
                        display: true,
                        text: ""
                    },
                    chart: {
                        dynamicAnimation: {
                        speed: 1000
                        }
                    },
                    scales: {
                        yAxes: [    // Y軸 
                            {
                                ticks: {            // 目盛り        
                                    min: 0,         // 最小値
                                    // beginAtZero: true でも同じ
                                    max: 100,       // 最大値
                                    stepSize: 10    // 間隔
                                }
                            }
                        ]
                    },
                    responsive: false
                }
        },
        executeFillData(main, sub) {
            switch (main) {
                case 0:
                    switch (sub) {
                        case 0:
                            this.fillDataTransitionDaily()
                            break;
                        case 1:
                            this.fillDataTransition7days()
                            break;
                        case 2:
                            this.fillDataTransition30days()
                            break;
                        default:
                            break;
                    }
                    break;
                case 1: 
                    switch (sub) {
                        case 0:
                            this.fillDataTotalingMonthly()
                            break;
                        case 1:
                            this.fillDataTotalingDayofWeek()
                            break;
                        case 2:
                            this.fillDataTotalingTimezone()
                            break;
                        default:
                            break;
                    }
                    break;
                default:
                    break;
            }
        },
        getDayArray(startDate, trackBack) {
            var dateList = new Array();

            for(var i = 0; i < trackBack; i++) {
                var formatedDate = startDate.getFullYear()+'-'+(startDate.getMonth()+1)+'-'+startDate.getDate();
                dateList.unshift(formatedDate);
                startDate.setDate(startDate.getDate() - 1)
            }
            return dateList
        }
    },
    watch: {
        selectedChartType: function(newSelectedChartType) {
            this.executeFillData(newSelectedChartType, 0)
            this.selectedTotalingType = 0
            this.selectedTransitionType = 0
        },
        selectedTotalingType: function(newSelectedTotalingType) {
            this.executeFillData(this.selectedChartType, newSelectedTotalingType)
        },
        selectedTransitionType: function(newSelectedTransitionType) {
            this.executeFillData(this.selectedChartType, newSelectedTransitionType)
        },
        date: function() {
            this.executeFillData(this.selectedChartType, this.selectedTotalingType)
        },
    },
    components: {
      LineChart,
      Bar,
    },
  }
</script>
