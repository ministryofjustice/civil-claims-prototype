/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, $ */

moj.Modules.calendar = (function() {
  "use strict";

  var init,
      cacheEls,
      bindEvents,
      newDate,
      nudgeDay,
      lz,
      displayCal,
      toggleCourt,

      $cal,
      $daynav,
      courts,
      courtboxes,
      triggers,
      dufflinks,
      $expandAll,
      $collapseAll,
      viewtoggles,
      caldisplay = false,
      dispdate,
      $currDate,
      $dayPrev,
      $dayNext,
      $historyToggle,
      $fullHistory;

  init = function() {

    cacheEls();
    bindEvents();

    if( document.location.hash === '#caldisplay=true' ) {
      $( 'a.calendarview' ).trigger( 'click' );
    }
    
    $cal.fullCalendar( {
      header:   {
        left:     'prev',
        center:   'title',
        right:    'next'
      },
      weekMode:       'variable',
      aspectRatio:    1.8,
      dayNamesShort:  [ 'S', 'M', 'T', 'W', 'T', 'F', 'S' ],
      dayClick:     function( date, allDay, jsEvent, view ) {
        var $day = $( jsEvent.target ).closest( '.fc-day' );

        if( !$day.hasClass( 'fc-sat' ) && !$day.hasClass( 'fc-sun' ) ) {
          $( '.fc-day' ).removeClass( 'fc-state-highlight' );
          $day.addClass( 'fc-state-highlight' );

          newDate( date );
        }
      }
    } );

    dispdate = $cal.fullCalendar( 'getDate' );
    newDate( dispdate );

    displayCal( caldisplay );
  };

  cacheEls = function() {
    $cal = $( '.calendar' ).eq( 0 );
    $daynav = $( '.daynav' ).eq( 0 );
    courts = $( '.court' );
    courtboxes = $( '.filters input.courtbox' );
    triggers = $( '.court .header h3 a' );
    dufflinks = $( 'a[href="#"]' );
    $expandAll = $( '.expandnav .expand a' ).eq( 0 );
    $collapseAll = $( '.expandnav .collapse a' ).eq( 0 );
    viewtoggles = $( '.controls .toggle a' );
    $currDate = $( '.daynav h2' ).eq( 0 );
    $dayPrev = $( '.daynav .prev' );
    $dayNext = $( '.daynav .next' );
    $historyToggle = $( '.toggle-history' ).eq( 0 );
    $fullHistory = $( '.full-history' ).eq( 0 );
  };

  bindEvents = function() {
    $( triggers ).on( 'click', function( e ) {
      var $this = $( this );
      e.preventDefault();
      toggleCourt( $this.closest( '.court' ) );
      this.blur();
    } );

    $expandAll.on( 'click', function() {
      $( courts ).each( function() {
        var $this = $( this );
        if( $this.hasClass( 'closed' ) ) {
          toggleCourt( $this );
        }
      } );
    } );

    $collapseAll.on( 'click', function() {
      $( courts ).each( function() {
        var $this = $( this );
        if( !$this.hasClass( 'closed' ) ) {
          toggleCourt( $this );
        }
      } );
    } );

    $( dufflinks ).on( 'click', function( e ) {
      e.preventDefault();
      this.blur();
    } );

    $( viewtoggles ).on( 'click', function( e ) {
      var $this = $( this );
      e.preventDefault();
      if( !$this.hasClass( 'current' ) ) {
        $( viewtoggles ).toggleClass( 'current' );
        caldisplay = !caldisplay;
        displayCal( caldisplay );
        document.location.hash = 'caldisplay=' + caldisplay;
      }
    } );

    $dayPrev.on( 'click', function() {
      nudgeDay( -1 );
    } );
    $dayNext.on( 'click', function() {
      nudgeDay( 1 );
    } );

    $( courtboxes ).on( 'change', function() {
      var $this = $( this ),
          i = $( courtboxes ).index( $this );

      $( courts[ i ] ).toggle();

    } );

    $historyToggle.on( 'click', function() {
      $fullHistory.toggle();
      $( this ).toggleClass( 'open' );
    } );

    $( '.court tr' ).on( 'click', function() {
      document.location.href = $( this ).find( '.number a' ).attr( 'href' );
    } );
  };

  toggleCourt = function( $court ) {
    var $courtBody = $court.find( '.body' ).eq( 0 );

    if( $court.hasClass( 'closed' ) ) {
      $court.toggleClass( 'closed' );
      $courtBody.slideDown( 100 );
    } else {
      $courtBody.slideUp( 100, function() {
        $court.toggleClass( 'closed' );
      } );
    }
  };

  newDate = function( date ) {
    dispdate = date;
    $currDate.text( $.fullCalendar.formatDate( date, 'dddd d MMMM yyyy') );
  };

  lz = function( n ) {
    return ( parseInt( n, 10 ) < 10 ? '0' + n : n );
  };

  nudgeDay = function( n ) {
    var ds;
    dispdate.setDate( dispdate.getDate() + n );
    if( dispdate.getDay() === 0 || dispdate.getDay() === 6 ) {
      // you've nudged into a weekend, so skip ahead 2 more days to escape
      dispdate.setDate( dispdate.getDate() + ( n * 2 ) );
    }
    $cal.fullCalendar( 'gotoDate', dispdate );

    ds = dispdate.getFullYear() + '-' + ( lz( dispdate.getMonth() + 1 ) ) + '-' + lz( dispdate.getDate() );

    $( '.fc-day' ).each( function() {
      var $this = $( this );
      if( $this.data( 'date' ) === ds ) {
        $this.trigger( 'click' );
      }
    } );
  };

  displayCal = function( show ) {
    if( show ) {
      $cal.addClass( 'show' );
      $daynav.removeClass( 'show' );
    } else {
      $cal.removeClass( 'show' );
      $daynav.addClass( 'show' );
    }
  };

  // public

  return {
    init: init
  };
}());
