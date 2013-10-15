/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, $ */

moj.Modules.forms = (function() {
  "use strict";

  var init,
      cacheEls,
      bindEvents,
      stripeElClick,

      stripeRows;

  init = function() {
    cacheEls();
    bindEvents();
  };

  cacheEls = function() {
    stripeRows = $( '.striped-choice .row' );
  };

  bindEvents = function() {
    $( stripeRows ).each( function() {
      $( this ).find( 'input[type="radio"], input[type="checkbox"], label' ).click( function( e ) {
        stripeElClick( e );
      } );
    } );
  };

  stripeElClick = function( e ) {
    var $row = $( e.target ).closest( '.row' ),
        $el = $row.find( 'input' ).eq( 0 ),
        elType = $el.attr( 'type' ),
        elName,
        buttons;

    if ( elType === 'radio') {
      elName = $el.attr( 'name' );
      $( 'input[name="' + elName + '"]' ).each( function() {
        $( this ).closest( '.row' ).removeClass( 'checked' );
      } );
      $row.addClass( 'checked' );
    } else { // checkbox
      if( $el.is( ':checked' ) ) {
        $row.addClass( 'checked' );
      } else {
        $row.removeClass( 'checked' );
      }  
    }
  };

  // public

  return {
    init: init
  };
}());
