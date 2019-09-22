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
  initialize: function(el){
    let tgt = $(el).find('input[init-value]');
    let v = tgt.attr('init-value');
    
    $(tgt).val(v);
    if (v !== ''){
      $(el).find('input.other-radio-input').prop('checked', true);
    }
  
  },
  // This returns a jQuery object with the DOM element
  find: function(scope) {
    return $(scope).find('div.cust-input-radio-group');
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    let selectedRadio = $(el).find('input:radio[name="' + el.id  + '"]:checked');
    
    console.log(selectedRadio);
    
    if(selectedRadio.length === 0){
      return null;
    } else if (selectedRadio.hasClass('other-radio-input')){
      return $(el).find('.other-radio-text-input').val();
    } else {
      return selectedRadio.val(); 
    }
  },
  subscribe: function(el, callback) {
    $(el).on('change.radioButtonsOther', function(event) {
      console.log('changed');
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off('.radioButtonsOther');
  }
});

Shiny.inputBindings.register(radioButtonsOther, 'shiny.radioButtonsOther');


/*
checbox other input binding
*/
var checkBoxesOther = new Shiny.InputBinding();
$.extend(checkBoxesOther, {

  // This returns a jQuery object with the DOM element
  find: function(scope) {
    return $(scope).find('div.cust-input-checkbox-group');
  },
  
  initialize: function(el){
    let initValue = $(el).find('.other-checkbox-text-input').attr('initial-value');
    if (initValue === undefined){
      let initValue = '';
    }
    
    $(el).find('.other-checkbox-input:checked').parent().find('.other-checkbox-text-input').val(initValue);
  },
  
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    var values = [];
  
    $(el).find('input[type=checkbox]:not(.other-checkbox-input):checked').each(function(){
      values.push($(this).val());
    });
    
    if ($(el).find('input[type=checkbox].other-checkbox-input:checked').length  == 1){
      let other_val = $(el).find('.other-checkbox-text-input').val();
      values.push(other_val);
    }
    
    return values;
  },
  subscribe: function(el, callback) {
    $(el).on('change.checkBoxesOther', function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off('.checkBoxesOther');
  }
});

Shiny.inputBindings.register(checkBoxesOther, 'shiny.checkBoxesOther');


// adderInput Binding
var checkboxTextBinding = new Shiny.InputBinding();
$.extend(checkboxTextBinding, {
  find: function(scope) {
    return $(scope).find(".checkbox-text-container");
  },
  getValue: function(el) {
    checked = $(el).find('input[type=checkbox]').prop('checked');
    if(checked){
      return $(el).find('input[type=text]').val();
    } else {
      return null;
    }
  },
  
  setValue: function(el, value) {
    $(el).text(value);
  },
  subscribe: function(el, callback) {
    $(el).on("change", '*',function(e) {
      callback();
    });
    
  },
  unsubscribe: function(el) {
    $(el).off(".incrementBinding");
  }
});
Shiny.inputBindings.register(checkboxTextBinding, "checkboxTextInput");