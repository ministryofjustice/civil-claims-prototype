
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
      that.parents('.control-group').after(data);
    });

  });

  var populate_address = function(container, address) {
    container.find('.address_street_1 input').val(address.street_1);
    container.find('.address_street_2 input').val(address.street_2);
    container.find('.address_street_3 input').val(address.street_3);
    container.find('.address_town input').val(address.town);
    container.find('.address_county input').val(address.county);
    container.find('.address_postcode input').val(address.postcode);

    window.claim.validate(container.parents('form')); 
  };

  // filthy address picker business
  $('#edit-claim').on('change', '.pick_address', function(event) {
    var master_form = $(this).parents('form');
    var address_element = master_form.find('.address-container');
    var picker = $(this).parents('.control-group');
    var address = $(this).find('option:selected').data('address');

    // are we showing the editable address form?
    if(address_element.find('.address_street_1 input').length == 0 ) {

      // the tragic downside of framework generated javascript is that I'm too
      // lazy to find a better way of triggering this behaviour
      address_element.find('.manual-address').click(); 

      setTimeout(function(){
        populate_address(master_form.find('.address-container'),address);
      }, 150); // callbacks are hard, let's just wait.

    } else {
      populate_address(address_element, address);
    }
  });

});

