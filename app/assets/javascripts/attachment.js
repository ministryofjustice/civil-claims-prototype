
function remove_attachment(link) {
  var parent_row = $(link).parent().parent(); 
  // $(link).closest(".tr")
  parent_row.find(":input").val("true").change();
  parent_row.hide('fast');

};

function add_attachments() {
  var att_index = $('tr:visible').length;
  var file_name = 'Another document('+att_index+').doc'
  $('#attachments-table tr:last').after('\
    <tr class="attachment-fields"> \
      <input id="claim_attachments_attributes_'+att_index+'__destroy" name="claim[attachments_attributes]['+att_index+'][_destroy]" type="hidden" value="false"> \
      <input id="claim_attachments_attributes_'+att_index+'_file_name" name="claim[attachments_attributes]['+att_index+'][file_name]" type="hidden" value="'+file_name+'"> \
      <td><a href="#">'+file_name+'</a></td> \
      <td><a class="btn btn-danger btn-small" href="#" onclick="remove_attachment(this); return false;">Remove</a></td> \
    </tr>');
}