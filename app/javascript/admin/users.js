$(document).ready(function() {
  $(".nav-link").click(function() {
    $(".nav-link").removeClass("active");
    $(this).addClass("active");
    var target = $(this).attr("href");
    $(".tab-pane").removeClass("show active");
    $(target).addClass("show active");
    if (target === "#edit-user-tab") {
      $("#working-time-tab").hide();
    } else {
      $("#working-time-tab").show();
    }
  });

  var url = window.location.href;
  var urlParams = url.split("?")[1];
  if (urlParams !== undefined) {
    var urlParam = urlParams.split("#")[0];
    var params = {};
    urlParam.split("&").forEach(function(param) {
      var key = param.split("=")[0];
      var value = param.split("=")[1];
      params[key] = value;
    });

    if (params.month && params.month.length !== 0 && params.year && params.year.length !== 0) {
      $(".nav-link").removeClass("active");
      $(".nav-working-time").addClass("active")
      $(".tab-pane").removeClass("show active")
      $("#working-time-tab").addClass("show active")
    }
  }
});


