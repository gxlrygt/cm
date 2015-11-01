'use strict';

angular.module('wholesale.controllers', []);
var wholesaleApp = angular.module('wholesale', ['ui.select2', 'wholesale.controllers', 'ngAnimate'])
    .config(['$httpProvider', function($httpProvider) {
      $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';
    }]);