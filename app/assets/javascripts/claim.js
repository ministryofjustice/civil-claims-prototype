window.claim = window.claim || {}

$(document).ready(function() {

  // usernav dropdown
  $('.dropdown > a').on('click', function (e) {
    $(this).parent().toggleClass('open');
  });

  // tabs
  $('#claims-index-tabs a').on('click', function (e) {
    var $this = $(this),
        tabs = $this.closest('ul').find('li'),
        tabpanes = $('.tab-pane'),
        i = $this.closest('ul').find('li').index($this.closest('li')),
        x;

    e.preventDefault();
    this.blur();

    for (x = 0; x < tabs.length; x++) {
      if(x === i) {
        $(tabs[x]).addClass('active');
        $(tabpanes[x]).show();
      } else {
        $(tabs[x]).removeClass('active');
        $(tabpanes[x]).hide();
      }
    }
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

  // when postcode is valid, enable Find Address link
  var validate_postcode_for_address_picker = function(evt) {
    if(this.validity.valid) {
      $(this).siblings('.find-uk-address').removeClass('disabled');
    } else {
      $(this).siblings('.find-uk-address').addClass('disabled');
    }
  }
  $('#edit-claim').on('keyup', '.postcode', validate_postcode_for_address_picker);

  $('#edit-claim').on('click', 'a.disabled', function(evt) {
    evt.preventDefault;
  });

  // click the Find Address link, see what happens
  $('#edit-claim').on('click', '.find-uk-address', function(evt) {
    evt.preventDefault();
    if($(this).hasClass('disabled')) {
      return false;
    }
    var postcode = $(this).siblings('.postcode').val();
    var that = $(this);

    $.ajax($(this).attr('href'), { 'data': { 'postcode': postcode } }).done(function(data, textStatus, jqXHR) {
      that.parents('form').find('.pick_address').remove();
      that.parents('.form-row').after(data);
    });

  });

  // filthy address picker business
  $('#edit-claim').on('change', '.pick_address', function(event) {
    var master_form = $(this).parents('form');
    var address_element = master_form.find('.address-container');
    var picker = $(this).parents('.control-group');
    var address = $(this).find('option:selected').data('address');

    claim.address.populate(master_form, address);
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
  } else {
    form.find("button[value='save']").attr('disabled', 'disabled');
  }
};

claim.address = {
  populate: function(container, address) {

    // are we showing the editable address form?
    if(container.find('.address_street_1 input').length == 0 ) {

      // the tragic downside of framework generated javascript is that I'm too
      // lazy to find a better way of triggering this behaviour
      container.find('.manual-address').click(); 

      setTimeout(function(){
        claim.address.feels_dirty(container, address);
        window.claim.validate(container.parents('form')); 
      }, 150); // callbacks are hard, let's just wait.

    } else {
      claim.address.feels_dirty(container, address);
      //window.claim.validate(container.parents('form')); 
    }
  },

  feels_dirty: function(container, address) {
    container.find('.address_street_1 input').val(address.street_1);
    container.find('.address_street_2 input').val(address.street_2);
    container.find('.address_street_3 input').val(address.street_3);
    container.find('.address_town input').val(address.town);
    container.find('.address_county input').val(address.county);
    container.find('.address_postcode input').val(address.postcode);
  },

};