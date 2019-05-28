// This input binding is very similar to textInputBinding from
// shiny.js.
var radioButtonsOther = new Shiny.InputBinding();

// An input binding must implement these methods
$.extend(radioButtonsOther, {

  // This returns a jQuery object with the DOM element
  find: function(scope) {
    return $(scope).find('.cust-input-radiogroup');
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    let selectedRadio = $('input:radio[name="' + el.id + '"]:checked');
    
    if(selectedRadio.hasClass('other-radio-input')){
      return $(el).find('.other-radio-text-input').val();
    } else {
      console.log(selectedRadio.val());
      return selectedRadio.val(); 
    }
  },
  subscribe: function(el, callback) {
    $(el).on('change.radioButtonsOther', function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off('.radioButtonsOther');
  }
});

Shiny.inputBindings.register(radioButtonsOther, 'shiny.radioButtonsOther');