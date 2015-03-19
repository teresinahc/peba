Module('Peba.Graficos.RecursosPorMes', {
  chart: {
    type: 'column',
    backgroundColor: 'transparent',
  },

  credits: { enabled: false },

  legend: { enabled: true },

  xAxis: {
    categories: [
      1,2,3,4,5,6,7,8,9,10,11,12
    ]
  },

  yAxis: {
    allowDecimals: true,
    min: 0
  },

  tooltip: {
    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
    pointFormat:  '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                  '<td style="padding:0"><b>{point.y}</b></td></tr>',
    footerFormat: '</table>',
    shared: true,
    useHTML: true
  },

  plotOptions: {
    column: {
      pointPadding: 0.2,
      borderWidth: 0
    }
  },

  series: []
});