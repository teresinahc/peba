Module('Peba.Graficos.GastoTotalPorMes', $.extend(true, {
  chart: { renderTo: 'gasto-total-por-mes' },
  title: {
    enabled: true,
    text: ''
  }
}, Peba.Graficos.RecursosPorMes));