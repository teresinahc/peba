Module('Peba.Application', function(Application) {
  'use strict';

  var initialized  = false;
  var initializers = [];

  /**
   * Add function to initializers array
   * @param {Function} fn
   */
  Application.addInitializer = function(fn) {
    initializers.push(fn);
  };

  /**
   * Run all functions inside initializers array
   * @return {void}
   */
  Application.run = function(attrs) {
    var key, value;

    if(!initialized) {
      for(key in attrs) {
        value = attrs[key];
        this[key] = value;
      }

      initializers.forEach(function(initializer){
        initializer();
      });

      initialized = true;
    }
  };
});
