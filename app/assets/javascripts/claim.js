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
  
  // click the Find Address link, see what happens
  $('#edit-claim').on('click', '.find-uk-address', function(evt) {
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
  $('#edit-claim').on('change', '.pick_address', function(event) {
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


  // kinda bad ;)
  $('.js-panel-component-details-show').on('click', function(event){
    var panels = $(event.target).parent().parent().nextAll('.component-details');
    $(panels[0]).removeClass('element-invisible');
    if(panels[1]){
      $(panels[1]).addClass('element-invisible');
    }

  });

  $('.js-panel-component-details-hide').on('click', function(event){
    var panels = $(event.target).parent().parent().nextAll('.component-details');
    $(panels[0]).addClass('element-invisible');
    if(panels[1]){
      $(panels[1]).removeClass('element-invisible');
    }
  });

};

$(document).ready(initPage);
$(window).bind('page:change', initPage);
