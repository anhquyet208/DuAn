$(document).ready(function () {
  const checkInDiv = $("[showhide='checkIn']");
  const checkOutDiv = $("[showhide='checkOut']");
  const fromDiv = $("[showhide='from']");
  const toDiv = $("[showhide='to']");


  ccdr($(".request-type-select").val())

  $(".request-type-select").on("change", function() {
    var requestType = $(this).val()
    ccdr(requestType)
  });

  function ccdr(requestType) {
    if (requestType === "check_in") {
      checkInDiv.removeClass("d-none");
      checkOutDiv.addClass("d-none").val('');
      fromDiv.addClass("d-none").val('');
      toDiv.addClass("d-none").val('');
      $("#request_check_in").prop("required", true);
      $("#request_check_out").prop("required", false);
      $("#request_from").prop("required", false);
      $("#request_to").prop("required", false);
    }
    else if (requestType === "check_out") {
      checkInDiv.addClass("d-none").val('');
      checkOutDiv.removeClass("d-none");
      fromDiv.addClass("d-none").val('');
      toDiv.addClass("d-none").val('');
      $("#request_check_in").prop("required", false);
      $("#request_check_out").prop("required", true);
      $("#request_from").prop("required", false);
      $("#request_to").prop("required", false);
    }
    else if (requestType === "day_off" || requestType === "remote") {
      checkInDiv.addClass("d-none").val('');
      checkOutDiv.addClass("d-none").val('');
      fromDiv.removeClass("d-none").prop('disabled', false);
      toDiv.removeClass("d-none").prop('disabled', false);
      $("#request_check_in").prop("required", false);
      $("#request_check_out").prop("required", false);
      $("#request_from").prop("required", true);
      $("#request_to").prop("required", true);
    }
  }

  $('.datepicker').datepicker({
    todayHighlight: true,
    orientation: 'auto top',
    format: 'yyyy-mm-dd'
  });
});
