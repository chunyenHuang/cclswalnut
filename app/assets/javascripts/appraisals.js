// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.



$('input.money-bank').on('keydown',function(e){    
    // tab, esc, enter
    if ($.inArray(e.keyCode, [9, 27, 13]) !== -1 ||
        // Ctrl+A
        (e.keyCode == 65 && e.ctrlKey === true) || 
        // home, end, left, right, down, up
        (e.keyCode >= 35 && e.keyCode <= 40)) {
        return;
    }
    
    e.preventDefault();
    
    // backspace & del
    if($.inArray(e.keyCode,[8,46]) !== -1){
        $(this).val('');
        return;
    }
    
    var a = ["a","b","c","d","e","f","g","h","i","`"];
    var n = ["1","2","3","4","5","6","7","8","9","0"];
    
    var value = $(this).val();
    var clean = value.replace(/\./g,'').replace(/,/g,'').replace(/^0+/, '');   
    
    var charCode = String.fromCharCode(e.keyCode);
    var p = $.inArray(charCode,a);
    
    if(p !== -1)
    {
        value = clean + n[p];
        
        if(value.length == 2) value = '0' + value;
        if(value.length == 1) value = '00' + value;
        
        var formatted = '';
        for(var i=0;i<value.length;i++)
        {
            var sep = '';
            if(i == 2) sep = ',';
            if(i > 3 && (i+1) % 3 == 0) sep = '.';
            formatted = value.substring(value.length-1-i,value.length-i) + sep + formatted;
        }
        
        $(this).val(formatted);
    }    
    
    return;
    
});