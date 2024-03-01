angular.module('cp_app').controller('home_ctrl', function($scope,$rootScope){
    console.log($rootScope);
    $rootScope.activeTab = 0;
    $rootScope.userDetails;
});