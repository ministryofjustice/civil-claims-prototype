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

  // Magic 'other...' in title field
  $('#edit-claim').on('change', 'form.edit-person select.title', function(event) {
    if('Other...' == $(this).val()) {
      $(this).replaceWith($('<input />', {
        name: $(this).attr('name'),
        id: $(this).attr('id'),
        class: $(this).attr('class'),
        type: 'text'
      }));
    }
  });

  // enable CSS validation once user tabs out of form field.  
  $('#edit-claim').on('blur', 'form.edit-person input', function(event) {
    if($(this).attr('required') || $(this).val().length ) {
      $(this).addClass('tabbed-out'); // register the interaction
      $(this).siblings('.icon-container').css('display', 'inline');
    } else {  // no validation indicator if field is optional & blank
      $(this).siblings('.icon-container').css('display', 'none');
    }
  });

  // enable html5 validation checking of the edit-person form
  $('#edit-claim').on('keyup', 'form.edit-person input', function(event) {
    claim.validate($(this).parents('form'));
  });

  $('form.edit-person').each(function(i, el) {
    claim.validate(el);
  });

  // filthy address picker business
  $('#edit-claim').on('change', '.pick_address', function(event) {
    var master_form = $(this).parents('form');
    var address_element = master_form.find('.address-container');

    var address = claim.address.extract_partial_address($(this).val());
    var picker = $(this).parents('.control-group');

    user_entered_postcode = address_element.find('.address_postcode input.postcode').val();
    if(user_entered_postcode.length > 0) {
      address.postcode = user_entered_postcode;
    }

    $.ajax('/address/random').done(function(random_address) {
      address = claim.address.merge(address, random_address);

      // are we showing the editable address form?
      if(address_element.find('.address_street_1 input').length == 0 ) {
        address_element.find('.manual-address').click();

        // this is my favourite hack out of this enture shitpile
        setTimeout(function(){
          claim.address.populate(master_form.find('.address-container'), address);
        }, 75); // callbacks are for turd-polishers. Real Coders just wait until the request completes.

      } else {
        claim.address.populate(address_element, address);
      }

      // keep the address picker 
      // picker.remove();
    });
  });

});

claim.validate = function(form) {
  form = $(form);
  var ready_to_go = form[0].checkValidity();
  var address_fields = 0;
  var field_names = ['address_street_1', 'address_street_2', 'address_street_3','address_town', 'address_county'];

  address_fields = field_names.map(function(f) { 
    if( form.find( 'input#'+f).length && form.find( 'input#'+f).val().length ) { return 1; }
    return 0;
  }).reduce(function(a, b) { return a + b; });

  if(address_fields < 2) {
    ready_to_go = false;
    if(form.find('input#address_street_1').length && !form.find('input#address_street_1').val().length) {
      form.find('input#address_street_1').attr('required', 'required').get(0).setCustomValidity('Not gonna happen');
    }
  } else {
    form.find('input#address_street_1').removeAttr('required').get(0).setCustomValidity('');
  }
  
  if( ready_to_go ) {
    form.find("button[value='save']").removeAttr('disabled');
    form.find("input[value='Cancel']").removeAttr('disabled');
  } else {
    form.find("button[value='save']").attr('disabled', 'disabled');
    form.find("input[value='Cancel']").attr('disabled', 'disabled');
  }
};

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

    window.claim.validate(container.parents('form')); 
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