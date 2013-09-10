 var scriptify_addresses = function() { 
  
  // click the Find Address link, see what happens
  $('body').on('click', '.find-uk-address', function(evt) {
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

  // handle selection from the address picker
  $('body').on('change', '.pick_address', function(event) {
    var container = $(this).parents('.edit-person');
    var address = $(this).find('option:selected').data('address');

    container.find('.address').removeClass('element-invisible').addClass('expando');
    populate_address(container, address);
  });


  var populate_address = function(container, address) {
    container.find("[class*='street_1'] input").val(address.street_1);
    container.find("[class*='street_2'] input").val(address.street_2);
    container.find("[class*='street_3'] input").val(address.street_3);
    container.find("[class*='town'] input").val(address.town);
    container.find("[class*='county'] input").val(address.county);
    container.find("[class*='postcode'] input").val(address.postcode);
  };
};

$(document).ready(scriptify_addresses);
$(window).bind('page:change', scriptify_addresses);
