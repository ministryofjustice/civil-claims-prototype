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
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require jquery.ui.effect-highlight

// want to hide something different then TR then add attribute to fn
remove_fields = function(link, association) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('tr').hide('fast');

  // hide the associated table when we are removing the last one
  if ($('#'+association+'-table tbody tr:visible').length==1)
    $('#'+association+'-table').hide('fast');
}

add_fields = function(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g');
  
 
  $('#'+association+'-table').show('fast');
  $('#'+association+'-table tbody').append(content.replace(regexp, new_id));

  content = fix_new_table_item_values(association);
}

toggle_panel = function (checkbox, panel_id){
  $('#'+panel_id).toggle('fast');
}

fix_new_table_item_values = function(association) {
  if(association=="arrears"){
    
    var rent = $('#claim_rental_amount').val() || 0;
    var contribution = $('#claim_contributions_this_month').val() || 0;
    var paid_sum = 0;
    // take the date from 'Rent due on'
    var last_arrear_date = format_date_form(
      // new Date(
      //   parseInt($('#claim_rent_due_date_1i').val()),
      //   parseInt($('#claim_rent_due_date_2i').val()-1),
      //   parseInt($('#claim_rent_due_date_3i').val()))
      // || 
      new Date());

    var rows = $('#arrears-table tbody tr:visible');
    var new_row_index = rows.length-1;
    
    rows.each(function(index){
      


      date_cell = this.cells[0]; //$(this).find('.arrears-duedate');
      amount_cell = this.cells[1]; //$(this).find('.arrears-amount');
      paid_cell = this.cells[2];
      arrear_cell = this.cells[3]; //$(this).find('.arrears-arrear');

      if(index == new_row_index){

        var new_arrear_date = new Date(last_arrear_date);
        new_arrear_date.setMonth(new_arrear_date.getMonth()+1);
        $(date_cell).find('input').val(format_date_form(new_arrear_date));
        $(date_cell).find('div').text(format_date(new_arrear_date));

        $(amount_cell).find('input').val(rent);
        $(amount_cell).find('div').text('\u00A3'+rent);
        
        var amount_paid = contribution - paid_sum;
        if (amount_paid<0) amount_paid=0;
        $(paid_cell).find('input').val(amount_paid);
        $(paid_cell).find('div').text('\u00A3'+amount_paid);

        var new_arrear_value = rent - amount_paid;
        if (new_arrear_value<0) new_arrear_value=0;
        // $(arrear_cell).find('input').val(new_arrear_value);
        $(arrear_cell).text('\u00A3'+new_arrear_value);

      }else{
        paid_sum += parseFloat($(paid_cell).find('input').val()) || 0;
        last_arrear_date = $(date_cell).find('input').val() || last_arrear_date;        
      }
    });

  }
  else if(association=="attachments"){
    var attachment_filename=$('#attachment-upload-filename').val();
    var new_row_filecell = $('#attachments-table tbody tr:visible:last td:first');
    $(new_row_filecell).find('input').val(attachment_filename);
    $(new_row_filecell).find('.attachments-filename').text(attachment_filename);
  }
}

// this will format date in edible format for simple_forms
format_date_form = function(date) { 
  return date.getFullYear()+'-'+
    ('0' + (date.getMonth()+1)).slice(-2) +'-'+
    ('0' + date.getDate()).slice(-2);
}

// this will format date to display
format_date = function(date) { 
  return ('0' + date.getDate()).slice(-2) + '/' +
    ('0' + (date.getMonth()+1)).slice(-2) + '/' +
    date.getFullYear();
}

set_random_filename_to = function(id){
  var filenames = 
    ["Crystal palace park road.pdf",
    "Tenancy Agreement July 2010.doc",
    "Notice to quit - June 2013.doc"];
  var random_filename = filenames[Math.floor(Math.random() * filenames.length)];

  $('#'+id).val(random_filename);
}




