var base_url = function(uri) {
  'use strict';
  uri = uri || null;

  var full_url = window.location.href,
      protocol = window.location.protocol,
      host     = window.location.host,
      base     = protocol + '//' + host;

  if(uri) {
    base += '/' + uri;
  }

  return base;
};