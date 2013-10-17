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
        var $this = $( this );
        $this.closest( '.row' ).removeClass( 'checked' );
        $this.closest( '.has-extra' ).removeClass( 'show-extra' );
      } );
      $row.addClass( 'checked' );
      $row.closest( '.has-extra' ).addClass( 'show-extra' );
    } else { // checkbox
      if( $el.is( ':checked' ) ) {
        $row.addClass( 'checked' );
        $row.closest( '.has-extra' ).addClass( 'show-extra' );
      } else {
        $row.removeClass( 'checked' );
        $row.closest( '.has-extra' ).removeClass( 'show-extra' );
      }  
    }
  };

  initStripeRows = function() {
    $( stripeRows ).each( function(){
      var $this = $( this ),
          $el = $this.find( 'input[type="radio"], input[type="checkbox"]' ).eq( 0 );

      if( $el[0].checked ) {
        $this.addClass( 'checked' );
        $el.closest( '.has-extra' ).addClass( 'show-extra' );
      }
    } );
  };

  // public

  return {
    init: init
  };
}());
