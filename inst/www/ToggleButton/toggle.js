// toggle.js
$(document).ready(function(){
  // helper functions
  getContainer = function(el){
    return $(el).closest('.toggle-button-container');
  };
  
  setButton = function(btn, selectedElement){
    var container = getContainer(btn);
    $(selectedElement).attr({'selected': 'true'});
    const nthChild = selectedElement.index() + 1;
    $(container).find('.toggle-opt:not(:nth-child(' + nthChild + '))').each(function(){
      $(this).removeAttr('selected');
    });
    btn.text(selectedElement.text());
    btn.attr({'value': selectedElement.attr('value')});
  };

  $(document).on('click', '.toggle-button', function(){
    var container = $(this).closest('.toggle-button-container');
    var opts = $(container).find('.toggle-opt');
    var optSelected = $(opts).filter('[selected="selected"]');
    var btn = $(container).find('.toggle-button');

    if(optSelected.index()+1 >= opts.length){
      var newSelected = $(opts[0]);
    } else {
      var newSelected = $(opts[optSelected.index()+1]);
    }
    
    setButton(btn, newSelected);
  });


});