/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, $ */

moj.Modules.forms = (function() {
  "use strict";

  var init,
      cacheEls,
      bindEvents,
      stripeElClick,
      initStripeRows,

      stripeRows;

  init = function() {
    cacheEls();
    bindEvents();

    initStripeRows();
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
        $el = $row.find( 'input[type="radio"], input[type="checkbox"]' ).eq( 0 ),
        elType = $el.attr( 'type' ),
        elName;

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

  initStripeRows = function() {
    $( stripeRows ).each( function(){
      var $this = $( this ),
          $el = $this.find( 'input[type="radio"], input[type="checkbox"]' ).eq( 0 );

      if( $el[0].checked ) {
        $this.addClass( 'checked' );
      }
    } );
  };

  // public

  return {
    init: init
  };
}());
