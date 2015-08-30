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
    var chart = null;

    transformer = transformer || function(options, data) {
      options.series[0].data = data;
      return options;
    };

    $.getJSON(base_url(uri), function(data) {
      if(data)  {
        chart = new Highcharts.Chart(transformer(options, data));
      }
    });
  };


  /**
   * Criar grafico de recursos por mes
   * @param  {String} uri
   * @param  {Object} options
   */
  API.prototype.recursosPorMes = function(uri, options) {
    this.criarGrafico(uri, options, function(options, data) {
      $.each(data, function(key, values) {
        // values = values.filter(function(v) { return v !== null; } );
        options.series.push({
          name: key,
          data: values
        });

        if(Math.max.apply(null, values.filter(Number)) >= 1000000) {
          options.yAxis.labels = {
            formatter:  function() {
              var absolute = (Math.abs(this.value) / 1000000);
              return this.value === 0 ? null : 'R$ ' + absolute + (absolute <= 1 ? ' Milhão' : ' Milhões')
            }
          };
        }
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
    var container = $('#gasto-total-por-mes'), url;

    if(container.length) {
      url = container.data('url');
      internalAPI.recursosPorMes(url, Peba.Graficos.GastoTotalPorMes);
    }
  };


  Peba.Application.addInitializer(Estatisticas.fn.initialize.bind(Estatisticas.fn));
});
