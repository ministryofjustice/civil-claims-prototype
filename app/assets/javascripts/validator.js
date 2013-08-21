(function($) {

  $.fn.validate_form = function() {
    var validity = this.get(0).checkValidity(); // native html5 method
    console.log('Form: ' + validity);
    return validity;
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
    console.log('enabling a thing!');
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
      this.removeAttr('required').each(function() { this.setCustomValidity(''); });
    } else {
      this.find(selector).validify();
    }
    return this;
  };

  $.fn.prevalidate = function() {
    this.init_validation_markup();
    this.init_validation_event();
    return this;
  };

  $.fn.init_validation_markup = function() {
    var vclass = 'icon-container';
    this.each( function() {
      if( $(this).siblings('.'+vclass).length === 0 ) {
        $(this).after("<span class='"+vclass+"' style='display:none' />");
      }
    });
    return this;
  };

  $.fn.init_validation_event = function() {

    var validation_handler = function(evt) {
      var element_uses_custom_validation = ( $(this).data('custom-validator') === true );
      if( !element_uses_custom_validation ) { $(this).validate(); }
    };

    this.filter(':not([data-validation-event-processed])').on('blur', validation_handler).attr('data-validation-event-processed');

    // init handler to capture change events
    // by javascript of whatever

    // this.each(function() {
    //   var el = $(this);
    //   el.data('old', el.val());
    //   el.on("propertychange keyup input paste", function(evt){
    //     if( el.data('old') != el.val() ) {
    //       el.data('old', el.val());
    //     }
    // });

    return this;
  };

  $.fn.has_custom_validator = function(fn) {
    this.data('custom-validator', 'true');
    return this;
  };

  $.fn.register_custom_validator = function(selector, event_name, fn) {
    var that = this;
    $(document).ready(function() { 
      that.on(event_name, selector, fn); 
    });
    return this;
  };

  // convenience function
  // returns true if elements are all blank
  $.fn.blank = function(selector) {
    if( typeof selector === 'undefined' ) {
      var blankness = true;
      this.each( function() {
        if ( $(this).val().length > 0) { 
          blankness = false;
        }
      });
      if( blankness ) {
        return true;
      } else {
        return false;
      }
    } else {
      return this.find(selector).blank();
    }
  };

  // returns true if the selector matches 1 or more elements
  $.fn.exists = function(selector) {
    if( typeof selector === 'undefined' ) {
      return (this.length > 0)
    } else {
      return this.find(selector).exists();
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

// bespoke validation for Claims/claimant forms

// expects form to be a jquery element
var address_form_validator = function(form) {
  var ready_to_go = form.validate();
  var field_names = ['address_street_1', 'address_street_2', 'address_street_3','address_town', 'address_county'];
  form.find('input#address_street_1').init_validation_markup().has_custom_validator();

  var address_fields = 0;
  $.each(field_names, function(f) { 
    var sel = 'input#'+field_names[f];
    if( form.exists( sel ) && !form.blank( sel )) { 
      address_fields += 1; 
    }
  });

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


$(document).ready(function() {
  // when postcode is valid, enable Find Address link
  $('#edit-claim').register_custom_validator('.postcode', 'keyup', function() {
    var address_finder_link = $(this).siblings('.find-uk-address');
    if($(this).valid()) { address_finder_link.enable(); } 
    else                { address_finder_link.disable(); }
  });


  // set up custom form validator
  $('#edit-claim').register_custom_validator('form.edit-person input', 'keyup', function() {
    address_form_validator($(this).parents('form'));
  });

  $('form.edit-person').each(function(i, el) {
    address_form_validator( $(el) );
  });
});