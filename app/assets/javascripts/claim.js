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
});