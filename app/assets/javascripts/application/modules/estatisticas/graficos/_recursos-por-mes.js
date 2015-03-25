Module('Peba.Graficos.RecursosPorMes', {
  chart: {
    type: 'column',
    backgroundColor: 'transparent'
  },

  credits: { enabled: false },

  legend: { enabled: true },

  xAxis: {
    categories: Highcharts.getOptions().lang.shortMonths,
    labels: {
      align: 'right',
      style: {
        fontSize: '13px',
        fontFamily: "'Helvetica Neue', Helvetica, Arial, sans-serif"
      }
    }
  },

  yAxis: {
    allowDecimals: true,
    min: 0,
    title: { enabled: true, text: "Valor em R$"},
    labels: {
      formatter:  function() {
        // this.axis.defaultLabelFormatter.call(this);
        var absolute = (Math.abs(this.value) / 1000000);
        return this.value === 0 ? null : 'R$ ' + absolute + (absolute <= 1 ? ' Milhão' : ' Milhões')
      }
    }
  },

  tooltip: {
    headerFormat: '<span>{point.key}</span><table>',
    pointFormat:  '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                  '<td style="padding:0"><b>R$ {point.y: ,.2f}</b></td></tr>',
    footerFormat: '</table>',
    shared: true,
    useHTML: true
  },

  plotOptions: {
    column: {
      dataLabels: {
        enabled: false,
        endOfTick: false,
        crop: false,
        overflow: 'none',
        color:'contrast',
        shadow: true,
        textShadow: "0 0 6px contrast, 0 0 3px contrast",
        format: "R$ {point.y: ,.2f}"
      }
    }
  },

  series: []
});