var workingDaysValues = [];
var userId;
var contId;
var siteURL;
var candidateId;
var getAllEvents;
var eventsOnLoad;
var maxStringSize = 6000000;    //Maximum String size is 6,000,000 characters
var maxFileSize = 4350000;      //After Base64 Encoding, this is the max file size
var chunkSize = 950000;         //Maximum Javascript Remoting message size is 1,000,000 characters
var attachment;
var attachmentName;
var fileSize;
var positionIndex;
var doneUploading;
var blobData;
var applicantName;

var app = angular.module('cp_app');
var sitePrefix = window.location.href.includes('/apex') ? '/apex' : '/CustomerDashboard';
app.config(function ($routeProvider, $locationProvider) {    
    $locationProvider.html5Mode(false).hashPrefix('');
    var rp = $routeProvider;

    for (var i = 0; i < tabValues.length; i++) {
        var pageName = '/' + tabValues[i].Name;

        if (tabValues[i].Apex_class_Name__c != undefined) {
            rp.when(pageName, {

                templateUrl: sitePrefix + pageName,
                controller: tabValues[i].Apex_class_Name__c
            });
        } else {
            rp.when(pageName, {
                templateUrl: sitePrefix + pageName,
            })
        }

    }
});

app.filter('specialChar',function(){
    return function(input)
    {
        return input ? input.replace(/&amp;/g,'&').replace(/&#39;/g,'\'').replaceAll('&amp;amp;','&').replaceAll('&amp;gt;','>').replaceAll('&lt;','<').replaceAll('lt;','<').replaceAll('&gt;','>').replaceAll('gt;','>').replaceAll('&amp;','&').replaceAll('amp;','&').replaceAll('&quot;','\'') : input;
    }
});

app.controller('cp_dashboard_ctrl', function ($scope, $rootScope, $timeout, $window, $location, $element){
    debugger;
    $scope.config = {};
    $rootScope.userDetails;
    $rootScope.activeTab = 0;
    $rootScope.siteURL = siteURL;

    $scope.baseUrl = window.origin; 

});