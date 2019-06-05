$(document).ready(function(){
  // All dynamic filter containers
  containers = $('.dynamic-filter-container');
  // Get the number of filters
  nFilters = function(container){
    return $(container).find('.filter-element').length;
  };
  
  // Disable / enable remove buttons as appropriate
  checkRemoveButtons = function(container){
    nFilt = nFilters(container);
    if(nFilt==1){
      $(container).find('.remove-element').attr({'disabled': true});
    } else {
      $(container).find('.remove-element').removeAttr('disabled');
    }
  };
  $(containers).each(function(){checkRemoveButtons(this)});

  // Changes the text in the dropdown
  $(document).on('click', '.dropdown-item', function(){
    var selectedText = $(this).text();

    btn = $(this).closest('.filter-element').find('.filter-type');
    $(btn).text(selectedText);
  });

  // Adds another filter
  $(document).on('click','.add-element', function(){
    container = $(this).closest('.dynamic-filter-container');
    newElement = $(container).find('.filter-element:first').clone();
    firstOpt = $(newElement).find('.dropdown-item:first').text();
    $(newElement).find('input').val('');
    $(newElement).find('.filter-type').text(firstOpt);
    $(container).find('.filter-elements').append(newElement);
    checkRemoveButtons(container);
  });

  // Removes filter if there is at least one other filter
  $(document).on('click', '.remove-element', function(){
    container = $(this).closest('.dynamic-filter-container');
    nFilt = nFilters(container);
    if (nFilt > 1){
     $(this).closest('.filter-element').remove(); 
    }
    checkRemoveButtons(container);
  });

});
