
function remove_arrear(link) {
  var parent_row = $(link).parent().parent(); 
  // $(link).closest(".tr")
  parent_row.find(":input").val("true");
  parent_row.hide('fast');
};


function add_arrear() {
  var att_index = $('#arrears-table tr:visible').length;

  var cells = $('#arrears-table tr:visible:last').find("td");
  var date= new Date();// new Date(cells[0].children[0].value);
  var amount= 300; 
  var arrear= 200; 
  
  if(cells && cells[1] && cells[2]){
       // date= new Date();// new Date(cells[0].children[0].value);
    amount= cells[1].children[0].value;
    arrear= cells[2].children[0].value;
  };


  //$('#arrears-table tr:visible:last').find("td")[0].children[0].value
  $('#arrears-table tbody').append('\
    <tr> \
      <input class="destroy" id="claim_arrears_attributes_'+att_index+'__destroy" name="claim[arrears_attributes]['+att_index+'][_destroy]" type="hidden" value="false"> \
      <td><input id="claim_arrears_attributes_'+att_index+'_due_date" name="claim[arrears_attributes]['+att_index+'][due_date]" type="date" value="'+date+'"></td> \
      <!-- :field_attribute, :value => format_method(f.object.field_attribute) %> --> \
      <td><input id="claim_arrears_attributes_'+att_index+'_amount" name="claim[arrears_attributes]['+att_index+'][amount]" type="number" value="'+amount+'"></td> \
      <td><input id="claim_arrears_attributes_'+att_index+'_arrear" name="claim[arrears_attributes]['+att_index+'][arrear]" type="number" value="'+arrear+'"></td> \
      <td> \
        <a class="btn btn-default btn-small" href="#" onclick="; return false;">Edit</a> \
        <a class="btn btn-danger btn-small" href="#" onclick="remove_arrear(this); return false;">X</a> \
      </td> \
    </tr>');
}