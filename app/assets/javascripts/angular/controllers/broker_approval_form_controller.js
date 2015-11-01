angular.module('wholesale.controllers').controller('BrokerApprovalFormController', ['$scope', '$http', '$log', function($scope, $http, $log) {
  $scope.init = function(brokerApprovalForm)
  {
    $scope.currentStep = "step1";
    $scope.brokerApprovalForm = brokerApprovalForm;

    if($scope.brokerApprovalForm.company_president)
    {
      var presidentName = $scope.brokerApprovalForm.company_president.split(" ");
      $scope.brokerApprovalForm.companyPresidentFirstName = presidentName[0];
      $scope.brokerApprovalForm.companyPresidentLastName = presidentName[1];
    }
    if($scope.brokerApprovalForm.primary_contact)
    {
      var name = $scope.brokerApprovalForm.primary_contact.split(" ");
      $scope.brokerApprovalForm.primaryContactFirstName = name[0];
      $scope.brokerApprovalForm.primaryContactLastName = name[1];
    }
  };

  $scope.addTpoUserAccess = function()
  {
    $scope.brokerApprovalForm.tpo_user_access_requests.push({email: null, first_name: null, last_name: null, nmls_expiration: null, nmls_issued: null, nmls_number: null, role: null});
    // HACKY
    setTimeout(function() {
      $('form .datetimepicker').datetimepicker();
    }, 200);
  };

  $scope.removeTpoUserAccess = function(index) 
  {
    $scope.brokerApprovalForm.tpo_user_access_requests.splice(index, 1);
  };

  $scope.isTpoUserAccessRemovable = function() 
  {
    return $scope.brokerApprovalForm.tpo_user_access_requests.length > 1;
  };

  $scope.hasTpoError = function(index, field)
  {
    return $scope.brokerApprovalForm.tpo_user_access_requests[index] && $scope.brokerApprovalForm.tpo_user_access_requests[index].errors && $scope.brokerApprovalForm.tpo_user_access_requests[index].errors[field];
  };

}]);