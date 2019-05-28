$(document).ready(function(){
  // All dynamic filter containers
  containers = $('.dynamic-filter-container');
  // Disable / enable remove buttons as appropriate
  checkRemoveButtons = function(container){
    console.log('TRYING');
    nFilters = $(container).find('.filter-element').length;
    console.log(nFilters);
    console.log(container);
    if(nFilters==1){
      $(container).find('.remove-element').attr({'disabled': true});
    } else {
      $(container).find('.remove-element').removeAttr('disabled');
    }
  };
  $(containers).each(function(){checkRemoveButtons(this)});

  // Changes the text in the dropdown
  $(document).on('click', '.dropdown-item', function(){
    var selectedText = $(this).text();
    console.log(selectedText);

    btn = $(this).closest('.input-group-prepend').find('.filter-type');
    $(btn).text(selectedText);
  });

  // Adds another filter
  $('.add-element').click(function(){
    container = $(this).closest('.dynamic-filter-container');
    newElement = $(container).find('.filter-element:first').clone();
    firstOpt = $(newElement).find('.dropdown-item:first').text();
    $(newElement).find('input').val('');
    $(newElement).find('.filter-type').text(firstOpt);
    newElement.insertBefore($(this).closest('.add-filter-element'));
    checkRemoveButtons(container);
  });

  // Removes filter
  $(document).on('click', '.remove-element', function(){
    container = $(this).closest('.dynamic-filter-container');
    $(this).closest('.filter-element').remove();
    n = $(container).find('.filter-element').length;
    checkRemoveButtons(container);
  });

});
