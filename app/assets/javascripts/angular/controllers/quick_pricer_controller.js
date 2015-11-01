angular.module('wholesale.controllers').controller('QuickPricerController', ['$scope', '$http', '$log', function($scope, $http, $log) {
  $scope.init = function(defaultStateId, defaultRateLockTerm, defaultPropertyUse, defaultPropertyType, defaultUnits, defaultStory, defaultAutoUwSystem)
  {
    REQUIRED_FIELDS = ["state_id", "county_name", "county_fips", "loan_amount", "appraisal_amount", "credit_score"];

    $scope.errors = {};
    $scope.searching = false;
    $scope.defaultSelect2Options = {
      
    };

    $scope.quickPricerObject ={
      state_id: null,
      property_use: defaultPropertyUse,
      property_type: defaultPropertyType,
      units: defaultUnits,
      stories: defaultStory
    };
    $scope.countySelect = {
      availableCounties: [],
      selectedCounty: null
    };
  };

  $scope.hasErrors = function()
  {
    return _.keys($scope.errors).length > 0;
  };

  $scope.hasError = function(key)
  {
    return !!$scope.errors[key]
  };

  validateErrors = function()
  {
    $scope.errors = {};
    if(!$scope.quickPricerObject.state_id || $scope.quickPricerObject.state_id == "")
    {
      $scope.errors["state_id"] = "Please choose a state";
    }
    if(!$scope.quickPricerObject.county_fips || $scope.quickPricerObject.county_fips == "")
    {
      $scope.errors["county_fips"] = "Please choose a county";
    }
    if(!$scope.quickPricerObject.loan_amount || $scope.quickPricerObject.loan_amount == "")
    {
      $scope.errors["loan_amount"] = "Please enter a loan amount";
    }
    if(!$scope.quickPricerObject.appraisal_amount || $scope.quickPricerObject.appraisal_amount == "")
    {
      $scope.errors["appraisal_amount"] = "Please enter an appraisal amount";
    }
    if(!$scope.quickPricerObject.credit_score || $scope.quickPricerObject.credit_score == "")
    {
      $scope.errors["credit_score"] = "Please enter a credit score";
    }
  };

  $scope.price = function()
  {
    validateErrors();
    if($scope.hasErrors())
    {
      return;
    }
    
    $scope.searching = true;
    $http.post("/quick_pricer/search", { quick_pricer: $scope.quickPricerObject }).
      then(function(response) {
        $scope.searching = false;
        if(response.data.quick_search_response && response.data.quick_search_response.quick_search_result && response.data.quick_search_response.quick_search_result.result && response.data.quick_search_response.quick_search_result.result.transaction_data && response.data.quick_search_response.quick_search_result.result.transaction_data.products && response.data.quick_search_response.quick_search_result.result.transaction_data.products.product)
        {
          $scope.products = response.data.quick_search_response.quick_search_result.result.transaction_data.products.product;
        }
        else
        {
          $scope.products = [];
        }
      }, function(response) {
        $scope.searching = false;
        $log.error("Unable to perform quick search");
        $log.error(response);
      });
  };

  $scope.$watch("quickPricerObject.state_id", function(newVal, oldVal) {
    if(newVal)
    {
      $scope.countySelect.selectedCounty = null;
      $scope.countySelect.availableCounties = [];

      $http.get("/states/" + newVal + "/counties").then(function(response) {
        $scope.countySelect.availableCounties = response.data;
      }, function(response) {
        $log.error("Error getting counties");
        $log.error(response);
        $scope.countySelect.selectedCounty = null;
      });
    }
  });

  $scope.$watch("countySelect.selectedCounty", function(newVal) {
    if(newVal && newVal != "")
    {
      newVal = JSON.parse(newVal);
      $scope.quickPricerObject.county_name = newVal['@name'];
      $scope.quickPricerObject.county_fips = newVal['@fips'];
    }
  });

  $scope.getCurrentTime = function()
  {
    var tz = jstz.determine();
    var tzAbbr = moment.tz.zone(tz.name()).abbr(new Date().getTime());
    return moment().format("M/D/YY h:mm A") + " " + tzAbbr;
  };

}]);
