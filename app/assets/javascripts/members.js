
$('input[type=uploadfile]').bootstrapFileInput();
$('.file-inputs').bootstrapFileInput();


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