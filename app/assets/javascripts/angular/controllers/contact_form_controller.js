angular.module('wholesale.controllers').controller('ContactFormController', ['$scope', '$http', '$log', function($scope, $http, $log) {
  $scope.errors = [];
  $scope.defaultSelect2Options = { };

  $scope.hasError = function()
  {
    return _.keys($scope.errors).length > 0;
  };

  var validateErrors = function()
  {
    $scope.errors = {};
    if(_.isUndefined($scope.name) || _.isNull($scope.name) || $scope.name == "")
    {
      $scope.errors["name"] = true;
    }
    if(_.isUndefined($scope.email) || _.isNull($scope.email) || $scope.email == "")
    {
      $scope.errors["email"] = true;
    }
    if(_.isUndefined($scope.message) || _.isNull($scope.message) || $scope.message == "")
    {
      $scope.errors["message"] = true;
    }
    if(_.isUndefined($scope.regarding) || _.isNull($scope.regarding) || $scope.regarding == "")
    {
      $scope.errors["regarding"] = true;
    }
  };

  $scope.submit = function()
  {
    if($scope.submittingForm)
    {
      return;
    }
    $scope.contactFormSubmitted = false;
    $scope.errorSubmittingForm = false;

    validateErrors();
    if($scope.hasError())
    {
      return;
    }
    
    $scope.submittingForm = true;
    $http.post("/contact_forms", { name: $scope.name, email: $scope.email, company: $scope.company, regarding: $scope.regarding, message: $scope.message }).
      then(function(response) {
        $scope.submittingForm = false;
        $scope.contactFormSubmitted = true;
      }, function(response) {
        $scope.submittingForm = false;
        $scope.errorSubmittingForm = true;
        $log.error("Unable to submit contact form");
        $log.error(response);
      });
  };


}]);
