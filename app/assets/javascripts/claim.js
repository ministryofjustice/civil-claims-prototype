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

  $('.edit-claim').on('change', '.edit-person .address-container .pick_address select', function(event) {
    var val = $(this).val();
    var address_element = $(this).parents('.address-container');
    var postcode = address_element.find('.address_postcode input.postcode').val();
    url = '/address/random';
    $.ajax(url).done(function(address) {
      address.street_1 = val.split(',')[0];
      address.town = val.split(',')[1];
      address.postcode = postcode;

      populate_address(address_element, address);
    })
  });

  function populate_address(element, address) {
    element.find('.address_street_1 input').val(address.street_1);
    element.find('.address_street_2 input').val(address.street_2);
    element.find('.address_street_3 input').val(address.street_3);
    element.find('.address_town input').val(address.town);
    element.find('.address_county input').val(address.county);
  }

});
