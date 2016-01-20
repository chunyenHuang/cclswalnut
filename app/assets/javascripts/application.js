// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require jquery.purr
//= require jquery.maskedinput
//= require jquery.maskedinput.min
//= require jquery.mouseover
//= require jquery_nested_form
//= require jquery.turbolinks
//= require autocomplete-rails
//= require rest_in_place
//= require best_in_place
//= require bootstrap
//= require bootstrap.min
//= require bootstrap-datepicker
//= require bootstrap.file-input.js
//= require dropdown
//= require turbolinks
//= require_tree .
jQuery(function($){
   $("#date").mask("99/99/9999",{placeholder:"mm/dd/yyyy"});
   $("#phone").mask("(999) 999-9999");
   $("#phone2").mask("(999) 999-9999");
   $("#phone3").mask("(999) 999-9999");
   $("#phone4").mask("(999) 999-9999");
   $("#phone5").mask("(999) 999-9999");
   $("#phone6").mask("(999) 999-9999");
   $("#tin").mask("99-9999999");
   $("#ssn").mask("999-99-9999");
   $("#money").mask("999,999");
});

$('input[type=file]').bootstrapFileInput();
$('.file-inputs').bootstrapFileInput();


$(document).on("click", "a.link_to_add_fields", function(e){
       e.preventDefault();
       var link = $(this);
       var association = $(this).data("association");
       var content = $(this).data("content");
       add_fields(link, association, content);
});

function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}





$(document).ready(function (){
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});

$(document).ready(function (){
        $('.dropdown-toggle').dropdown();
    });

  function printpage()
{
   window.print()
}

  $( "[data-mask]").each (index, value) ->
    element = $(value)
    element.mask($(value).data('mask'))



$(document).ready(function (){

  $(document).bind('ajaxError', 'form#new_person', function(event, jqxhr, settings, exception){

    // note: jqxhr.responseJSON undefined, parsing responseText instead
    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

  });

});

(function($) {

  $.fn.modal_success = function(){
    // close modal
    this.modal('hide');

    // clear form input elements
    // todo/note: handle textarea, select, etc
    this.find('form input[type="text"]').val('');

    // clear error state
    this.clear_previous_errors();
  };

  $.fn.render_form_errors = function(errors){

    $form = this;
    this.clear_previous_errors();
    model = this.data('model');

    // show error messages in input form-group help-block
    $.each(errors, function(field, messages){
      $input = $('input[name="' + model + '[' + field + ']"]');
      $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
    });

  };

  $.fn.clear_previous_errors = function(){
    $('.form-group.has-error', this).each(function(){
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    });
  }

}(jQuery));
