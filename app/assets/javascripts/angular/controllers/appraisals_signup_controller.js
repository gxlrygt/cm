angular.module('wholesale.controllers').controller('AppraisalsSignupController', ['$scope', '$http', '$log', function($scope, $http, $log) {
  $scope.signupRequested = false;
  $scope.signupForm = {};

  $scope.signup = function()
  {
    if($scope.signupRequested)
    {
      return;
    }
    $scope.signupRequested = true;
    $scope.signupSuccess = false;
    $scope.signupError = false;
    $http.post("/broker_center/appraisals_signup_request", { signup_form: $scope.signupForm }).
      then(function(response) {
        $scope.signupRequested = false;
        if(response.data.code == 200)
        {
          $scope.signupSuccess = true;
          $scope.signupSuccessMessage = response.data.message;
        }
        else
        {
          $scope.signupError = true;
          $scope.signupErrorMessage = response.data.message;
        }
      }, function(response) {
        $scope.signupError = true;
        $scope.signupRequested = false;
        $scope.signupErrorMessage = "Unable to register. Please try again, or if the problem persists, contact support."
      });
  };

}]);
