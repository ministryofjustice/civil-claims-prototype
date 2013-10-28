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
      changeLandlords,
      changeTenants,
      landlordTenantAddressRadioClick,

      //elements
      postcodeButtons,
      manualAddressLinks,
      landlordAddressRadios,
      tenantAddressRadios,

      //vars
      currLandlords = 1,
      currTenants = 1,

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
    initTemplates();

    cacheEls();
    bindEvents();
  };

  cacheEls = function() {
    postcodeButtons = $( '.js-find-address' );
    manualAddressLinks = $( '.js-manual-address' );
    landlordAddressRadios = $( '.options.js-landlord-address input[type="radio"]' );
    tenantAddressRadios = $( '.options.js-tenant-address input[type="radio"]' );
  };

  bindEvents = function() {
    $( postcodeButtons ).each( function() {
      $( this ).unbind( 'click' ).on( 'click', function( e ) {
        e.preventDefault();
        getRandomAddresses( $( e.target ) );
      } );
    } );

    $( manualAddressLinks ).each( function() {
      $( this ).unbind( 'click' ).on( 'click', function( e ) {
        e.preventDefault();
        manualAddressFields( $( e.target ) );
      } );
    } );

    $( landlordAddressRadios ).add( tenantAddressRadios ).each( function() {
      $( this ).unbind( 'click' ).on( 'click', function( e ) {
        landlordTenantAddressRadioClick( $( e.target ) );
      } );
    } );

    $( '.addressDropdown' ).unbind('change').on( 'change', function( e ) {
      pickAddress( $( e.target ) );
    } );

    $( '#numlandlords' ).on( 'change', function() {
      changeLandlords( $( this ) );
    } );

    $( '#numtenants' ).on( 'change', function() {
      changeTenants( $( this ) );
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
    bindEvents();

    moj.Modules.effects.highlights();
  };

  joinAddress = function( address ) {
    return address.street + ', ' + address.town + ', ' + address.postcode;
  };

  pickAddress = function( $el ) {
    var address = fakeAddresses[ $el.val() ],
        $panel = $el.closest( '.sub-panel' ),
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
    var $panel = $el.closest( '.sub-panel' ),
        $pcRow = $el.closest( '.row' ).prev(),
        html;

    html = '<div class="row rel street highlight"><label>Street</label><textarea></textarea></div>';
    html += '<div class="row rel town highlight"><label>Town</label><input type="text"></div>';

    $panel.find( '.row.street, .row.town' ).remove();
    $pcRow.addClass( 'rel' ).before( html );
    $pcRow.addClass( 'highlight' ).find( 'input[type="text"]' ).val( '' );
    // $el.closest( '.row' ).remove();

    moj.Modules.effects.highlights();
  };

  changeLandlords = function( $el ) {
    var landlords = $el.val(),
        x;
    if( landlords < currLandlords ) {
      // remove landlords
      $( '.landlord-form' ).each( function( n ) {
        var $this = $( this );
        if( (n+1) > landlords ) {
          $this.remove();
        }
      } );
    } else if( landlords > currLandlords ) {
      // add landlords
      for( x = currLandlords; x < landlords; x++ ) {
        var source = $('#landlord-template').html(),
            template = Handlebars.compile(source),
            context = {grouping: 'landlord'+(x+1), additional: true};

        $( '.landlords-wrapper' ).append(template(context));
      }
    }

    currLandlords = landlords;

    cacheEls();
    bindEvents();
  };

  changeTenants = function( $el ) {
    var tenants = $el.val(),
        x;
    if( tenants < currTenants ) {
      // remove tenants
      $( '.tenant-form' ).each( function( n ) {
        var $this = $( this );
        if( (n+1) > tenants ) {
          $this.remove();
        }
      } );
    } else if( tenants > currTenants ) {
      // add tenants
      for( x = currTenants; x < tenants; x++ ) {
        var source = $('#tenant-template').html(),
            template = Handlebars.compile(source),
            context = {grouping: 'tenant'+(x+1), additional: true};

        $( '.tenants-wrapper' ).append(template(context));
      }
    }

    currTenants = tenants;

    cacheEls();
    bindEvents();
  };

  initTemplates = function() {
    var lsource = $( '#landlord-template' ).html(),
        ltemplate = Handlebars.compile( lsource ),
        lcontext = { grouping: 'landlord1' },
        tsource = $( '#tenant-template' ).html(),
        ttemplate = Handlebars.compile( tsource ),
        tcontext = { grouping: 'tenant1' };

    $( '.landlords-wrapper' ).append( ltemplate( lcontext ) );
    $( '.tenants-wrapper' ).append( ttemplate( tcontext ) );
  };

  landlordTenantAddressRadioClick = function( $el ) {
    var source,
        template,
        context,
        $fieldset = $el.closest( 'fieldset' ),
        $panel = $el.closest( '.sub-panel' );

    $panel.find( '.postcode-fragment-wrapper' ).remove();

    if( $el.closest( '.row' ).hasClass( 'js-different' ) ) {
      source = $( '#postcode-fragment' ).html();
      template = Handlebars.compile( source );
      context = { grouping: $panel .attr( 'id' ) };


      $fieldset.after( template( context ) );

      cacheEls();
      bindEvents();
    }
  };

  // public

  return {
    init: init
  };
}());
