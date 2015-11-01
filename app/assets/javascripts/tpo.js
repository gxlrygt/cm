$(document).ready(function() {
  var displayTpoLoginMessage = function(message)
  {
    $("#tpo-login-message").html(message);
    if(message == "")
    {
      $("#tpo-login-message").hide();
    }
    else
    {
      $("#tpo-login-message").show();
    }
  };

  needToVerifyTpoCredentials = true;
  tpoCredentialsValid = false;
  $("#tpo-login-username, #tpo-login-password").change(function() {
    needToVerifyTpoCredentials = true;
  });
  $("#tpo-login").submit(function(e) {
    var username = $("#tpo-login-username").val();
    var password = $("#tpo-login-password").val();
    if(_.isEmpty(username) || _.isEmpty(password))
    {
      e.preventDefault();
      return false;
    }
    displayTpoLoginMessage("");
    if(needToVerifyTpoCredentials)
    {
      e.preventDefault();
      $("#tpo-login-spinner").show();
      $.post("/attempt_tpo_login", { username: username, password: password })
        .done(function(resp) {
          needToVerifyTpoCredentials = false;
          if(resp.result)
          {
            tpoCredentialsValid = true;
            $("#tpo-login").submit();
          }
          else
          {
            tpoCredentialsValid = false;
            displayTpoLoginMessage("<div class='has-error'><div class='form-control'><p>Your login information is invalid</p></div></div>");
          }
      }).fail(function(resp) {
        if(window.console && window.console.log)
        {
          console.log("Unable to verify TPO credentials");
          console.log(resp);
        }
        displayTpoLoginMessage("We are having issues verifying your credentials. Please try again later or contact support.");
      }).always(function() {
        $("#tpo-login-spinner").hide();
      });
    }
    else
    {
      if(!tpoCredentialsValid)
      {
        // Not good. Stop submitting this form.
        e.preventDefault();
        return false;
      }
      // We're good, just let them through
    }
  });
});