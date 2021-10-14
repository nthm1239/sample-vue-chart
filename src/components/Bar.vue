<script>
import { Bar, mixins  } from 'vue-chartjs'
import 'chartjs-plugin-colorschemes'
export default {
  name: 'LineChart',
  mixins: [Bar, mixins.reactiveProp],
  extends: Bar ,
  props: ['chartData','options'],
  mounted() {
    this.renderChart(this.data, this.options)
  }
}
</script>