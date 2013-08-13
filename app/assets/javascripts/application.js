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
function remove_fields(link, association) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('tr').hide('fast');

  // hide the associated table when we are removing the last one
  if ($('#'+association+'-table tbody tr:visible').length==1)
    $('#'+association+'-table').hide('fast');
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g');
  
  content = fix_new_table_idem_values(association, content);
 
  $('#'+association+'-table').show('fast');
  $('#'+association+'-table tbody').append(content.replace(regexp, new_id));

}

function toggle_panel(checkbox, panel_id){
  $('#'+panel_id).toggle('fast');
}

function fix_new_table_idem_values(association, content) {
  if(association=="arrears"){
    
    var rent = $('#claim_rental_amount').val() || 0;
    var contribiution = $('#claim_contributions_this_month').val() || 0;
    var arrears_sum =0.0;
    $('#arrears-table tbody td .arrears-arrear:visible').each(function(index){
      arrears_sum += parseFloat($(this).val()) || 0;
    });
    console.log('rent: '+rent);
    console.log('contribution: '+contribiution);
    console.log('already arrears: '+arrears_sum);

    return content
      .replace('arrears_new_item_amount', rent)
      .replace('arrears_new_item_arrear', rent-contribiution-arrears_sum);
  }
  else if(association=="attachments"){

  }
  return content;
}


