/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, $ */

moj.Modules.tabs = (function() {
  "use strict";

  var init,
      cacheEls,
      bindEvents,
      $activeTab,
      tabClick;

  init = function() {
    cacheEls();
    bindEvents();
  };

  cacheEls = function() {
    $activeTab = $( '.claims-index-tabs a.is-active-tab' ).eq ( 0 );
  };

  bindEvents = function() {
    $activeTab.on( 'click', function( e ) {
      e.preventDefault();
      this.blur();
      tabClick( $( this ) );
    } );
  };

  tabClick = function( $el ) {
    var tabs = $el.closest( 'ul' ).find( 'li' ),
        tabpanes = $( '.tab-pane' ),
        i = $el.closest( 'ul' ).find( 'li' ).index( $el.closest( 'li' ) ),
        x;

    e.preventDefault();
    this.blur();

    for ( x = 0; x < tabs.length; x++ ) {
      if( x === i ) {
        $( tabs[ x ] ).addClass( 'active' );
        $( tabpanes[ x ] ).show();
      } else {
        $( tabs[ x ] ).removeClass( 'active' );
        $( tabpanes[ x ] ).hide();
      }
    }
  };

  // public

  return {
    init: init
  };
}());
