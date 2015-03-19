var base_url = function(uri) {
  'use strict';
  uri = uri || null;

  var full_url = window.location.href,
      protocol = window.location.protocol,
      host     = window.location.host,
      base     = protocol + '//' + host;

  if(window.location.href.match(/[a-z]\/educacaocontinuada/g) !== null) { // is a folder inside datagenno.com
    var full_url_without_protocol = full_url.replace(/https?:\/\//g, '');
    base = protocol + '//' + host + '/' + full_url_without_protocol.split('/')[1];
  }

  if(uri) {
    base += '/' + uri;
  }

  return base;
};