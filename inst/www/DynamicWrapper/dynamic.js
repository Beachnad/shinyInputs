// Dynamic js
$(document).ready(function(){
  
  $(document).on('click', '.dynamic-wrapper-container .add-btn', function(){
    console.log("Click Detected");
    
    var container = $(this).closest('.dynamic-wrapper-container');
    var copyElement = $(container).find('.element-copy > *:first-child').clone();
    copyElement.appendTo($(container).find('.multi-container'));
  });
  
});