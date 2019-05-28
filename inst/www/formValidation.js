class ValidatorGroup {
  constructor(rootElement){
    this.el = rootElement;
  }
  
  isRequired() {return $(this.el).find('[required]').length}
  isValid(){
    throw new EvalError('Abstract isValid() function must be overwritten.');
  }
  validate(){
    if(this.isValid()){
      
    }
  }
}

class vTextWidget extends ValidatorGroup {
  inputObject() {return $(this.el).find('input');}
  value() {return $(this.inputObject).val();}
  isEmpty() {return $(this.inputObject).length}
  isValid() {}
}


function setValid(x){
  $(x).removeClass('is-invalid');
  $(x).addClass('is-valid');
}

function setInvalid(x){
  $(x).removeClass('is-valid');
  $(x).addClass('is-invalid');
}

function validateRequired(x){
  isRequired = $(x).find('[required]').length;
  if (isRequired){
    type = $(el).find('.form-group').attr('data-type');
    if (['text', 'number'].includes(type)){
      x = $(x).find('input');
      val = $(x).val();
      if(val.length){
        return true;
      } else {
        setInvalid(x);
        return false;
      }
    }
    
    val = $(x).val();
    if(val.length <= 0){
      setInvalid(x);
      return false;
    } else {
      return true;
    }
  } else {
    return true;
  }
}

function validateNumber(x){
  val = parseInt($(x).val());
  min = parseInt($(x).attr('min'));
  max = parseInt($(x).attr('max'));
  
  if ( (val < max || isNaN(max)) &&
       (val > min || isNaN(min)) ){
    setValid(x);
  } else {
    setInvalid(x);
  }
}

function validateText(x){
  val = $(x).val();
  valLength = val.length;
  maxLength = parseInt($(x).attr('max-length'));
  minLength = parseInt($(x).attr('min-length'));
  
  console.log(maxLength);
  
  if ( (valLength > minLength || isNaN(minLength)) &
       (valLength < maxLength || isNaN(maxLength)) ) {
    setValid(x);
  } else {
    setInvalid(x);
  }
}

function validateInput(el) {
  // Check if input passes the required validation, then return if failed.
  validRequired = validateRequired(el);
  if(!validRequired){return}
    
  type = $(el).find('.form-group').attr('data-type');
  
  switch(type){
    case 'number':
      input = $(el).find('input');
      validateNumber(input);
      break;
    case 'text':
      input = $(el).find('input');
      validateText(input);
      break;
    case 'checkbox':
      validateCheckkboxGroup(el);
      break;
  }
  
}

$(document).ready(function() {
  
  $('.btn-validate').click(function(){
    var form = $(this).closest("form");
    
    $(form).find('.validate-input').each(function(){
      validateInput(this);
    });
    
  });
  
});
