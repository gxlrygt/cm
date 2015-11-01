angular.module('wholesale.controllers').controller('ResourcesController', ['$scope', '$timeout', function($scope, $timeout) {
  var links = {
    "defaultDisclosures": "http://www.commercehomemortgagewholesale.com/Disc_Default.pdf",
    "disclosuresTX": "http://www.commercehomemortgagewholesale.com/Disc_Tx.pdf",
    "harpTX": "http://www.commercehomemortgagewholesale.com/Disc_Harp_Tx.pdf",
    "harp": "http://www.commercehomemortgagewholesale.com/Disc_Harp.pdf"
  };

  $scope.defaultSelect2Options = {
      
  };

  $scope.downloadPackage = function()
  {
    var link = null;
    if($scope.state && $scope.loanType && $scope.state != "" && $scope.loanType != "")
    {
      if($scope.state == "Texas")
      {
        if($scope.loanType == "HARP")
        {
          link = links["harpTX"];
        }
        else
        {
          link = links["disclosuresTX"];
        }
      }
      else
      {
        if($scope.loanType == "HARP")
        {
          link = links["harp"];
        }
        else
        {
          link = links["defaultDisclosures"];
        }
      }

      if(link)
      {
        $scope.packageLink = link;
        $timeout(function() {
          window.open(link);
        }, 200);
      }
    }
  };

}]);
