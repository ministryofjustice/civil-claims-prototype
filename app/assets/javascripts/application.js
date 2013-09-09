// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.ui.effect-highlight
//= require validator
//= require addresses

//= require claim

// want to hide something different then TR then add attribute to fn
var remove_fields = function(link, association) {
  $(link).prev('input[type=hidden]').val('1');
  
  if(association==="arrears"){
    // hide the associated table when we are removing the last one
    if ($('#'+association+'-table tbody tr:visible').length==1)
      $('#'+association+'-table').hide('fast');

    var current_row = $(link).closest('tr');
    var arrear_value = $(current_row).find('.arrears-arrear input').val();
    var total_arrears = parseFloat($('#arrears-total-amount input').val()) - arrear_value;
    $('#arrears-total-amount input').val(total_arrears);
    $('#arrears-total-amount-text').text('\u00A3'+total_arrears.toFixed(1));
    $(link).closest('tr').hide('fast');

  } else if(association==="attachments"){
    $(link).closest('li').hide('fast');
  }
};

var add_fields = function(link, association, content) {
  var errors="";

  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g');
  
  if(association=="arrears"){
    $('#rental-arrears-error').hide();
    
    var rent = $('#claim_rental_amount').val() || 0;
    var contribution = $('.js-arrears-month-contribution').val() || 0;
    
    var rent_due_on_data=[
      parseInt($('#arrears-select-year').val()),
      parseInt($('#arrears-select-month').val()),
      parseInt($('#arrears-select-day').val())];

    if(isNaN(rent_due_on_data[0] + rent_due_on_data[1] + rent_due_on_data[2])) {
      errors=errors+"Please select rent due date. ";
    }
    
    if(isNaN(rent)) {
      errors=errors+"Rental amount should be a number value. ";
    }
    
    if(isNaN(contribution)) {
      errors=errors+"Payment amount should be a number value. ";
    }

    if(errors){
      $('#rental-arrears-error').show('fast');
      $('#rental-arrears-error').text(errors);
    } else {
      var arrear_date = new Date(rent_due_on_data[0], rent_due_on_data[1]-1, rent_due_on_data[2]);
      var rent_value = parseFloat(rent);
      var contribution_value = parseFloat(contribution);
      var arrear_value = rent_value - contribution_value;
      
      content= content.replace('arrears-duedate-new-item-hidden',format_date_form(arrear_date));
      content= content.replace('arrears-duedate-new-item-text',format_date(arrear_date));
      content= content.replace(new RegExp('arrears-amount-new-item', 'g'), rent_value.toFixed(1));
      content= content.replace(new RegExp('arrears-paid-new-item', 'g'), contribution_value.toFixed(1));
      content= content.replace(new RegExp('arrears-arrear-new-item', 'g'), arrear_value.toFixed(1));
      
      $('#arrears-select-month').val(rent_due_on_data[1]+1);
      $('#arrears-table').show('fast');
      $('#arrears-table tbody').append(content.replace(regexp, new_id));

      var total_arrears = parseFloat($('#arrears-total-amount input').val()) + arrear_value;
      $('#arrears-total-amount input').val(total_arrears);
      $('#arrears-total-amount-text').text('\u00A3'+total_arrears.toFixed(1));

      $('.js-arrears-month-contribution').val(null);
    }
  } else if(association=="attachments"){
    var file_name=get_random_filename;
    content= content.replace(new RegExp('attachments-filename-new-item','g'),file_name);
    $('#attachments-list').append(content.replace(regexp, new_id));
  }

};

var toggle_panel = function (checkbox, panel_id){
  $('#'+panel_id).toggle('fast');
};

var show_panel = function( panel_id ){
  $('#'+panel_id).show('fast');
};

var hide_panel = function( panel_id ){
  $('#'+panel_id).hide('fast');
};


// this will format date in edible format for simple_forms
var format_date_form = function(date) {
  return date.getFullYear()+'-'+
    ('0' + (date.getMonth()+1)).slice(-2) +'-'+
    ('0' + date.getDate()).slice(-2);
};

// this will format date to display
var format_date = function(date) {
  return ('0' + date.getDate()).slice(-2) + '/' +
    ('0' + (date.getMonth()+1)).slice(-2) + '/' +
    date.getFullYear();
};

var get_random_filename = function(){
  var filenames = 
    ["Crystal palace park road.pdf",
    "Tenancy Agreement July 2010.doc",
    "Notice to quit - June 2013.doc"];
  return filenames[Math.floor(Math.random() * filenames.length)];
};

var show_payment_panel = function(panel_id){
  $('#credit-card-details').hide();
  $('#paypal-details').hide();
  $('#worldpay-details').hide();
  
  $('#'+panel_id).show();
};
