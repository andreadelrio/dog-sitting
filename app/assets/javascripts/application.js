//= require jquery
//= require jquery_ujs
//= require jquery.flexslider-min.js
//= require bootstrap/transition
//= require bootstrap/collapse
//= require bootstrap/dropdown
//= require bootstrap/collapse
//= require bootstrap/tooltip
//= require bootstrap/z_popover
//= require bootstrap/modal
//= require bootstrap/tab
//= require jquery-ui
//= require datepicker-es.js
//= require jquery.timepicker.min.js
//= require easing
//= require_self
//= require_tree .

$(document).ready(function() {
  var docHeight = $(window).height();
  var footerHeight = $('#footer').height();
  var footerTop = $('#footer').position().top + footerHeight;

  if (footerTop < docHeight) {
    $('#footer').css('margin-top', 10+ (docHeight - footerTop) + 'px');
  }

  // modal for referral codes
  $(document).bind('ajaxError', 'form#new_referral', function(event, jqxhr, settings, exception){

    // note: jqxhr.responseJSON undefined, parsing responseText instead
    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

  });
  //timepicker

  $('#booking_pickup_time').timepicker({
    'minTime': '9:00am',
    'maxTime': '6:00pm',
  });
  $('#booking_dropoff_time').timepicker({
    'minTime': '9:00am',
    'maxTime': '6:00pm',
  });

  // pretty-fy the upload field
  // var realInputField = $('#provider_pictures_attributes_0_image');
  var realInputField = $('#provider_avatar');
  var picCache = $("#provider_avatar_cache")

  //ocultar campos innecesarios en providers#edit
  $('img').filter(function(){
          return !$(this).attr('src');
  }).hide();
  $("a[href='/provider_attachments']").hide()
  
  //ocultar secciones de disqus
   $('[data-tracking-area="footer"]').hide();
  //validate datepickers
  $("input.form-search").click(function(event){
    if($("#start_date").val() == "" | $("#end_date").val() == "") {
      event.preventDefault(); // cancel default behavior
      // alert("llenalo");
      $("#fechas-warning").show();
    }
    //... rest of add logic
  });
  // initialize jquery-ui datepicker
  $.datepicker.setDefaults(
    $.extend(
      $.datepicker.regional['es']
    )
  );
  $('#start_date').datepicker({
  	  minDate: new Date(),
      dateFormat: 'dd/mm/yy',
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#end_date" ).datepicker( "option", "minDate", selectedDate );
      }
    });
  
  $('#end_date').datepicker({
  	  minDate: new Date(),
      dateFormat: 'dd/mm/yy',
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#end_date" ).datepicker( "option", "minDate", selectedDate );
      }
    });

  // drop just the filename in the display field
  realInputField.change(function() {
    // $('#file-display').val $(@).val().replace(/^.*[\\\/]/, '');
    $('#file-display').val("Archivo elegido: " + realInputField.val().replace(/^.*[\\\/]/, ''));
    $('#archivo-elegido').hide();
  });

  // trigger the real input field click to bring up the file selection dialog
  $('#upload-btn').click(function() {
    realInputField.click();
  });

  $(window).load(function() {
    $('.flexslider').flexslider({
    	controlNav: true,
    });
  });
});

function checkAll(){
	// Pass in a named "Check All" checkbox that appears on the same form where all 
	// checkboxes should be checked.
	main_checkbox = document.getElementById("check_all");

	// Loop through an array containing ALL inputs on same form as check_all
	location_checkboxes = document.getElementsByClassName("location_cbx");
	for (var i = 0; i < location_checkboxes.length; i++) {  
	  // Only work on checkboxes, and NOT on the "Check All" checkbox
    if(main_checkbox.checked == true){
      location_checkboxes[i].checked = true ;
    }else{
      location_checkboxes[i].checked = false;
    }
	};
}

function uncheckMain(location_checkbox) {
	var tracker = 0;
	main_checkbox = document.getElementById("check_all");
		if(location_checkbox.checked == false) {
			main_checkbox.checked = false;
		};
	location_checkboxes = document.getElementsByClassName("location_cbx");	
		for (var i = 0; i < location_checkboxes.length; i++) {  
		  // Only work on checkboxes, and NOT on the "Check All" checkbox
		  if (location_checkboxes[i].type == "checkbox") { 
		    if(location_checkboxes[i].checked == true){
		      tracker ++;
		    }
		  }  
		};
	  if (tracker == location_checkboxes.length) {
	    main_checkbox.checked = true;
	  }
}

function allLabel() {
	main_checkbox = document.getElementById("check_all");
	if (main_checkbox.checked == true) {
		main_checkbox.checked = false;
		checkAll();
	}else{
		main_checkbox.checked = true;
		checkAll();
	}
}

// referrals
(function($) {

  $.fn.modal_success = function(){
    // close modal
    // this.modal('hide');
    // this.removeClass('hidden');
    this.find('.modal-title').html("Este es tu código de descuento. Cuando realices tu próxima reserva, utiliza este código y obtén 10% de descuento.");
    this.find('.modal-body').hide();

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


function disqus_config() {
  this.callbacks.afterRender = [function() {
    console.log("disqus");
  }];
}










