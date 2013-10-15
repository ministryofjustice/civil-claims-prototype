/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, $ */

moj.Modules.temp = (function() {
  "use strict";

  var init,
      cacheEls,
      bindEvents;

  init = function() {
    cacheEls();
    bindEvents();
  };

  cacheEls = function() {
    
  };

  bindEvents = function() {
    // $( 'summary' ).on( 'focus', function() {
    //   this.blur();
    // } );
  };

  // public

  return {
    init: init
  };
}());
