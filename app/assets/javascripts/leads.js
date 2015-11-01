$(document).ready(function() {
  var clearFreeConsultationFormErrors = function()
  {
    $("#leads_first_name").parent().removeClass("has-error");
    $("#leads_last_name").parent().removeClass("has-error");
    $("#leads_email").parent().removeClass("has-error");
    $("#leads_phone").parent().removeClass("has-error");

    $(".leads-message").hide();
  };
  var submittingLead = false;
  $("#leads_submit").click(function(e) {
    e.preventDefault();

    if(submittingLead)
    {
      return false;
    }
    clearFreeConsultationFormErrors();
    var firstName = $("#leads_first_name").val();
    var lastName = $("#leads_last_name").val();
    var email = $("#leads_email").val();
    var phone = $("#leads_phone").val();
    if(!_.isEmpty(firstName) && !_.isEmpty(lastName) && !_.isEmpty(email))
    {
      $(".leads-spinner").show();
      submittingLead = true;
      var promise = $.post("/leads", {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
      }, null, "json");
      promise.done(function(data) {
        if(window.console && window.console.log)
        {
          console.log("Lead created!");
          console.log(data);
        }
        $(".leads-message").text("Thank you! Your information has been submitted.").show();
      });
      promise.fail(function(data) {
        if(window.console && window.console.log)
        {
          console.log("Failed to create lead");
          console.log(data);
        }
        $(".leads-message").text("We were unable to submit your information. Please try again later.").show();
      });
      promise.always(function() {
        submittingLead = false;
        $(".leads-spinner").hide();
      });
    }
    else
    {
      if(_.isEmpty(firstName))
      {
        $("#leads_first_name").parent().addClass("has-error");
      }
      if(_.isEmpty(lastName))
      {
        $("#leads_last_name").parent().addClass("has-error");
      }
      if(_.isEmpty(email))
      {
        $("#leads_email").parent().addClass("has-error");
      }
    }
  });
});