window.claim = window.claim || {}

$(document).ready(function() {

  $('#claims-index-tabs li.submit a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  });

  $('#claims-index-tabs li.list a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  });

  $('.inline-help .toggle-help').click(function(e) {
      e.preventDefault();
      var $collapse = $(this).closest('.collapse-group').find('.collapse').collapse('toggle');
      $(this).toggleClass('toggle-hidden').toggleClass('toggle-visible');
  });

  // filth
  $('#edit-claim').on('change', '.pick_address select', function(event) {
    var master_form = $(this).parents('form');
    var address_element = master_form.find('.address-container');

    var address = claim.address.extract_partial_address($(this).val());

    user_entered_postcode = address_element.find('.address_postcode input.postcode').val();
    if(user_entered_postcode.length > 0) {
      address.postcode = user_entered_postcode;
    }

    $.ajax('/address/random').done(function(random_address) {
      address = claim.address.merge(address, random_address);

      if(address_element.find('.address_street_1 input').length == 0 ) {
        address_element.find('.manual-address').click();
        setTimeout(function(){
          claim.address.populate(master_form.find('.address-container'), address);
        }, 50);
      } else {
        claim.address.populate(address_element, address);
      }
    });
  });



});

claim.address = {
  merge: function( primary, secondary ) {
    for (var attrname in secondary) { 
      if(!primary.hasOwnProperty(attrname)) {
        primary[attrname] = secondary[attrname];
      }
    }
    return primary;
  },

  populate: function(container, address) {
    container.find('.address_street_1 input').val(address.street_1);
    container.find('.address_street_2 input').val(address.street_2);
    container.find('.address_street_3 input').val(address.street_3);
    container.find('.address_town input').val(address.town);
    container.find('.address_county input').val(address.county);
    container.find('.address_postcode input').val(address.postcode);
  },

  extract_partial_address: function(address_string) {
    var address = {};
    var sections = address_string.split(',');
    if(sections.length > 1) {
      address.street_1 = sections[0];
      address.town = sections[1].trim();
    }
    return address
  }
};