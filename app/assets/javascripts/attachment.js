
function remove_attachment(link) {
  var parent_row = $(link).parent().parent(); 
  // $(link).closest(".tr")
  parent_row.find(":input").val("true");
  parent_row.hide('fast');

};

function add_attachments() {
  var att_index = $('tr:visible').length;
  var file_names = [
      "Crystal palace park road.pdf",
      "Tenancy Agreement July 2010.doc",
      "Notice to quit - June 2013.doc"];
  var file_name = file_names[Math.floor(Math.random() * 3)]

    $('#attachments-table tbody').append('\
    <tr class="attachment-fields"> \
      <input id="claim_attachments_attributes_'+att_index+'__destroy" name="claim[attachments_attributes]['+att_index+'][_destroy]" type="hidden" value="false"> \
      <input id="claim_attachments_attributes_'+att_index+'_file_name" name="claim[attachments_attributes]['+att_index+'][file_name]" type="hidden" value="'+file_name+'"> \
      <td><a href="#">'+file_name+'</a></td> \
      <td><a class="btn btn-danger btn-small" href="#" onclick="remove_attachment(this); return false;">Remove</a></td> \
    </tr>');
}