<script>
import { Line, mixins  } from 'vue-chartjs'
import 'chartjs-plugin-colorschemes'
export default {
  name: 'LineChart',
  mixins: [Line, mixins.reactiveProp],
  extends: Line ,
  props: ['chartData','options'],
  mounted() {
    this.renderChart(this.data, this.options)
  }
}
</script>