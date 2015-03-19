Module('Peba.Estatisticas', function(Estatisticas) {
  'use strict';

  var internalAPI = null;

  /**
   * ########################################################################################
   * Private interface ######################################################################
   * ########################################################################################
  */

  function API(context) {
    this.context = context;
  }


  /**
   * Criar grafico
   * @param  {Strint} uri
   * @param  {Object} options
   * @param  {Function} transformer
   */
  API.prototype.criarGrafico = function(uri, options, transformer) {
    transformer = transformer || function(options, data) {
      options.series[0].data = data;
      return options;
    };

    $.getJSON(base_url(uri), function(data) {
      if(data) new Highcharts.Chart(transformer(options, data));
    });
  };


  /**
   * Criar grafico de recursos por mes
   * @param  {String} uri
   * @param  {Object} options
   */
  API.prototype.recursosPorMes = function(uri, options) {
    this.criarGrafico(uri, options, function(options, data) {
      console.log(data);
      $.each(data, function(key, value) {
        options.series.push({
          name: key,
          data: value
        });
      });
      return options;
    });
  };



  /**
   * ########################################################################################
   * Public interface #######################################################################
   * ########################################################################################
  */

  Estatisticas.fn.initialize = function() {
    internalAPI = new API(this);
    this.gastoTotalPorMes();
  };


  /**
   * Gastos anuais por mes
   */
  Estatisticas.fn.gastoTotalPorMes = function() {
    if($('#gasto-total-por-mes').length) {
      internalAPI.recursosPorMes('gasto_total.json', Peba.Graficos.GastoTotalPorMes);
    }
  };



  Peba.Application.addInitializer(Estatisticas.fn.initialize.bind(Estatisticas.fn));
});
