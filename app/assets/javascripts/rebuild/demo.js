/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, $ */

moj.Modules.demo = (function() {
  "use strict";

  var //functions
      init,
      cacheEls,
      bindEvents,
      getRandomAddresses,
      joinAddress,
      pickAddress,
      manualAddressFields,
      initTemplates,

      //elements
      postcodeButtons,
      manualAddressLinks,

      //vars
      currLandlords = 1,

      //data
      fakeAddresses = [
        {
          street:     '2 Newburgh St',
          town:       'London',
          postcode:   'W1F 7RD'
        },
        {
          street:     '31 Sloane St',
          town:       'London',
          postcode:   'SW1X 9NR'
        },
        {
          street:     '29B High Street',
          town:       'Alness',
          postcode:   'IV17 0PT'
        },
        {
          street:     '19 Tweed Place',
          town:       'Johnstone',
          postcode:   'PA5 0PL'
        },
        {
          street:     '5 Shireland Road',
          town:       'Smethwick',
          postcode:   'B66 4RD'
        },
        {
          street:     '35A Dowanhill Road',
          town:       'London',
          postcode:   'SE6 1SU'
        },
        {
          street:     '9 New Close',
          town:       'Holmrook',
          postcode:   'CA19 1UB'
        }
      ];

  init = function() {
    cacheEls();
    bindEvents();

    initTemplates();
  };

  cacheEls = function() {
    postcodeButtons = $( '.js-find-address' );
    manualAddressLinks = $( '.js-manual-address' );
  };

  bindEvents = function() {
    $( postcodeButtons ).each( function() {
      $( this ).on( 'click', function( e ) {
        e.preventDefault();
        getRandomAddresses( $( e.target ) );
      } );
    } );

    $( manualAddressLinks ).each( function() {
      $( this ).on( 'click', function( e ) {
        e.preventDefault();
        manualAddressFields( $( e.target ) );
      } );
    } );

    $( document ).on( 'change' , '.addressDropdown', function( e ) {
      pickAddress( $( e.target ) );
    } );

    $( '#numlandlords' ).on( 'change', function() {
      var landlords = $( this ).val(),
          x;
      if( landlords < currLandlords ) {
        console.log('remove');
        // remove landlords
        $( '.landlord-form' ).each( function( n ) {
          var $this = $( this );
          if( (n+1) > landlords ) {
            console.log('remove '+n);
            $this.remove();
          }
        } );
      } else if( landlords > currLandlords ) {
        // add landlords
        for( x = currLandlords; x < landlords; x++ ) {
          var lsource = $('#landlord-template').html(),
              ltemplate = Handlebars.compile(lsource),
              lcontext = {grouping: 'landlord'+x, additional: true};

          $( '.landlords-wrapper' ).append(ltemplate(lcontext));
        }
      }

      currLandlords = landlords;
    } );
  };

  getRandomAddresses = function( $el ) {
    var html,
        x;

    html = '<div class="row rel highlight"><select class="addressDropdown"><option value="">Select address...</option>';
    for( x = 0; x < fakeAddresses.length; x++ ) {
      html += '<option value="' + x + '">' + joinAddress( fakeAddresses[ x ] ) + '</option>';
    }
    html += '</select></div>';


    $el.closest( '.row' ).after( html );

    moj.Modules.effects.highlights();
  };

  joinAddress = function( address ) {
    return address.street + ', ' + address.town + ', ' + address.postcode;
  };

  pickAddress = function( $el ) {
    var address = fakeAddresses[ $el.val() ],
        $panel = $el.closest( '.moj-panel' ),
        $ddRow = $el.closest( '.row' ),
        $pcRow = $ddRow.prev(),
        html;

    $pcRow.find( 'input[type="text"]' ).val( address.postcode );

    html = '<div class="row rel street highlight"><label>Street</label><textarea>' + address.street + '</textarea></div>';
    html += '<div class="row rel town highlight"><label>Town</label><input type="text" value="' + address.town + '"></div>';

    $panel.find( '.row.street, .row.town' ).remove();
    $pcRow.addClass( 'rel highlight' ).before( html );
    $ddRow.remove();

    moj.Modules.effects.highlights();
  };

  manualAddressFields = function( $el ) {
    var $panel = $el.closest( '.moj-panel' ),
        $pcRow = $el.closest( '.row' ).prev(),
        html;

    html = '<div class="row rel street highlight"><label>Street</label><textarea></textarea></div>';
    html += '<div class="row rel town highlight"><label>Town</label><input type="text"></div>';

    $panel.find( '.row.street, .row.town' ).remove();
    $pcRow.addClass( 'rel' ).before( html );

    moj.Modules.effects.highlights();
  };

  initTemplates = function() {
    var lsource = $('#landlord-template').html(),
        ltemplate = Handlebars.compile(lsource),
        lcontext = {grouping: 'landlord1'};

    $( '.landlords-wrapper' ).append(ltemplate(lcontext));
  };

  // public

  return {
    init: init
  };
}());
