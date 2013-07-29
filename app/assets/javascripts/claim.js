$('#claims-index-tabs li.submit a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});

$('#claims-index-tabs li.list a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});