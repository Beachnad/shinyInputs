// Bindings

// adderInput Binding
var adderBinding = new Shiny.InputBinding();
$.extend(adderBinding, {
  find: function(scope) {
    return $(scope).find(".dynamic-filter-container");
  },
  getValue: function(el) {
    for (var b = $(el).find('.filter-type'), labs = new Array(b.length), i = 0; i < b.length; i++)
                labs[i] = b[i].textContent;
                
    for (var b = $(el).find('.filter-element input[type=text]'), vals = new Array(b.length), i = 0; i < b.length; i++)
              vals[i] = b[i].value;
    
    var data = {
      "labels": labs,
      "values": vals
    };
    
    return data;
  },
  
  setValue: function(el, value) {
    $(el).text(value);
  },
  subscribe: function(el, callback) {
    $(el).on("change", '*',function(e) {
      callback();
    });
        
    $(el).on("click", '*',function(e) {
      // Had to add a small pause so that the remove UI events would
      // occur (updating the data), then the callback would occur.
      setTimeout(function() {
        callback();  
      }, 10);
    });
    
  },
  unsubscribe: function(el) {
    $(el).off(".incrementBinding");
  }
});
Shiny.inputBindings.register(adderBinding, "adderInput");

var toggleButtonBinding = new Shiny.InputBinding();
$.extend(toggleButtonBinding, {
  find: function(scope) {
    return $(scope).find(".toggle-button-container");
  },
  getId: function(el) {
    return $(el).attr('id');
  },
  getValue: function(el) {
    var val = $(el).find('button.toggle-button').attr('value');
    console.log(val);
    return val;
  },
  setValue: function(el, value) {
    $(el).find('li[value="' + value  + '"]').attr({'selected': 'true'});
  },
  subscribe: function(el, callback) {
    $(el).on("click", function(e) {
      setTimeout(function() {callback();}, 10);
    });
  },
  unsubscribe: function(el) {
    // TODO: this
  }
});

Shiny.inputBindings.register(toggleButtonBinding, "toggleButton");



/*
Radio input binding
*/
var radioButtonsOther = new Shiny.InputBinding();
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

