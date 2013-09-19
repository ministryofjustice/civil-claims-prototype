var initPage = function(){
  // usernav dropdown
  $('.dropdown > a').on('click', function (e) {
    $(this).parent().toggleClass('open');
  });

  // tabs
  $('.claims-index-tabs a.is-active-tab').on('click', function (e) {
    var $this = $(this),
        tabs = $this.closest('ul').find('li'),
        tabpanes = $('.tab-pane'),
        i = $this.closest('ul').find('li').index($this.closest('li')),
        x;

    e.preventDefault();
    this.blur();

    for (x = 0; x < tabs.length; x++) {
      if(x === i) {
        $(tabs[x]).addClass('active');
        $(tabpanes[x]).show();
      } else {
        $(tabs[x]).removeClass('active');
        $(tabpanes[x]).hide();
      }
    }
  });

  $('.inline-help .toggle-help').click(function(e) {
      e.preventDefault();
      var $collapse = $(this).closest('.collapse-group').find('.collapse').collapse('toggle');
      $(this).toggleClass('toggle-hidden').toggleClass('toggle-visible');
  });

  // Magic 'other...' in title field
  $('#edit-claim').on('change', 'form.edit-person select.title', function(event) {
    if('Other...' == $(this).val()) {
      $(this).replaceWith($('<input />', {
        name: $(this).attr('name'),
        id: $(this).attr('id'),
        class: $(this).attr('class'),
        type: 'text'
      }));
    }
  });
  

  // kinda bad ;)
  // change this to html5 data- attribute passing an id
  $('.js-panel-component-details-show').on('click', function(e){
    var panels = $(e.target).parent().parent().nextAll('.component-details');
    $(panels[0]).removeClass('element-invisible');
    if(panels[1]){
      $(panels[1]).addClass('element-invisible');
    }

  });

  $('.js-panel-component-details-hide').on('click', function(e){
    var panels = $(e.target).parent().parent().nextAll('.component-details');
    $(panels[0]).addClass('element-invisible');
    if(panels[1]){
      $(panels[1]).removeClass('element-invisible');
    }
  });


  $('.js-add-arrear').bind('ajax:before', function(e, data, status, xhr) {
    console.log(e);
    console.log(data);
    console.log(status);
    console.log(xhr);

    // if (status == "success"){
    //   $('.js-supporting-documents-panel').append(data.responseText);
    // }

    if (status =="error"){
      $('#errors').append(data.responseText);
    }

  });


};

$(document).ready(initPage);
$(window).bind('page:change', initPage);
