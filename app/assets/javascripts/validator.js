(function($) {

  $.fn.validate_form = function() {
    this.each( function() {
      this.checkValidity(); // native html5 method
    });
  };

  // called on a validation event (generally on blur)
  $.fn.validate_form_element = function() {
    this.each( function() {
      var required = $(this).attr('required');
      var filled_in = ( $(this).val().length > 0 );
      var validates = this.validity.valid;      // native html5 method

      var register = function(el) { $(el).addClass('tabbed-out'); };
      var deregister = function(el) { $(el).removeClass('tabbed-out'); };

      // register an interaction if this is a required field
      if( required ) { register(this); }
      
      // or if it's been filled in
      else if( filled_in ) { register(this); }

      // otherwise, don't hassle me bro
      else { deregister(this); }

    });
    return this;
  };

  // validate a single element
  $.fn.valid = function() {
    return this.get(0).validity.valid;
  };

  $.fn.validate = function() {
    this.each( function() {
      switch( this.tagName.toLowerCase() ) {
        case 'form':
          $(this).validate_form();
          break;
        case 'input':
        case 'select':
          $(this).validate_form_element();
          break;
      }
    });
  };


  // two styles of calling these functions:
  // $('.myForm a').enable() or
  // $('.myForm').enable('a')
  $.fn.enable = function(selector) {
    if( typeof selector === 'undefined' ) {
      this.removeClass('disabled');
      this.removeAttr('disabled');
    } else {
      this.find(selector).enable();
    }
    return this;
  };


  $.fn.disable = function(selector) {
    if( typeof selector === 'undefined' ) {
      this.addClass('disabled');
      this.attr('disabled', 'disabled');
    } else {
      this.find(selector).disable();
    }
    return this;
  };

  $.fn.invalidify = function(selector) {
    if( typeof selector === 'undefined' ) {
      this.attr('required', 'required').each(function() { this.setCustomValidity('You failed validation!'); });
    } else {
      this.find(selector).invalidify();
    }
    return this;
  };

  $.fn.validify = function(selector) {
    if( typeof selector === 'undefined' ) {
      this.removeAttr('required').each(function() { this.setCustomerValidity(''); });
    } else {
      this.find(selector).validify();
    }
    return this;
  };

  $.fn.prevalidate = function() {
    var vclass = 'icon-container';
    this.each( function() {
      if( $(this).siblings('.'+vclass).length === 0 ) {
        $(this).after("<span class='"+vclass+"' style='display:none' />");
      }
    });
    this.off('blur').on('blur', function(evt) {
      if(!$(this).data('custom-validator')) { $(this).validate(); }
    });
    return this;
  };

  $.fn.has_custom_validator = function(fn) {
    this.data('custom-validator', 'true');
    return this;
  }

  // convenience function
  // can only be called on a single element
  $.fn.blank = function(selector) {
    if( typeof selector === 'undefined' ) {
      if(this.length === 1 && this.val().length === 0) { return true; }
      else { return false; }
    } else {
      return this.find(selector).blank();
    }
  };

  // set up some expected behaviours

  // disabled links won't do anything
  $('body').on('click', 'a.disabled', function(evt) {
    evt.preventDefault();
  });

  // set up the dom to show validation errors
  $(document).ready(function() {
    $('body').addClass('validation-enabled');
    $('form [data-validate]').prevalidate();
  });

  // hmm, this should watch for new form elements too
  $(document).on('DOMSubtreeModified', function() {
    $('form [data-validate]').prevalidate();
  });

})(jQuery);

// expects form to be a jquery element
var address_form_validator = function(form) {
  var ready_to_go = form.validate();
  var address_fields = 0;
  var field_names = ['address_street_1', 'address_street_2', 'address_street_3','address_town', 'address_county'];

  address_fields = field_names.map(function(f) { 
    if( form.blank( 'input#'+f) ) { return 1; }
    else { return 0; }
  }).reduce(function(a, b) { return a + b; });

  if(address_fields < 2) {
    ready_to_go = false;
    if(form.blank('input#address_street_1')) {
      form.invalidify('input#address_street_1');
    }
  } else {
    form.validify('input#address_street_1');
  }
  
  if( ready_to_go ) {
    form.enable("button[value='save']");
  } else {
    form.disable("button[value='save']");
  }
};

// when postcode is valid, enable Find Address link
$('#edit-claim').on('keyup', '.postcode', function(evt) {
  var address_finder_link = $(this).siblings('.find-uk-address');
  if($(this).valid()) { address_finder_link.enable(); } 
  else                { address_finder_link.disable(); }
});


// set up custom form validator


$('#edit-claim').on('keyup', 'form.edit-person input', function(event) {
  address_form_validator($(this).parents('form'));
});

$('form.edit-person').each(function(i, el) {
  address_form_validator($(el);
});

