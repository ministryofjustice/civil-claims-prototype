/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, $ */

moj.Modules.demo = (function() {
  "use strict";

  var init,
      cacheEls,
      bindEvents,
      findAddress,

      postcodeButtons;

  init = function() {
    cacheEls();
    bindEvents();
  };

  cacheEls = function() {
    postcodeButtons = $( '.js-find-address' );
  };

  bindEvents = function() {
    $( postcodeButtons ).each( function() {
      $( this ).on( 'click', function( e ) {
        e.preventDefault();
        findAddress( $( e.target ) );
      } );
    } );
  };

  findAddress = function( $el ) {
    var html = '<select>'; // YOU ARE HERE
    $el.closest.row.after();
  };

  // public

  return {
    init: init
  };
}());
