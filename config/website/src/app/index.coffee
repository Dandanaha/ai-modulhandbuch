angular.module "modulmanager", ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngRoute', 'ngMaterial','cb.x2js']
  .config ($routeProvider,$locationProvider,$sceDelegateProvider) ->
    $sceDelegateProvider.resourceUrlWhitelist([
     'self'
     'http://ai.it.hs-worms.de/**'
    ])
    $locationProvider.html5Mode(true).hashPrefix '!'
    $routeProvider
      .when "/",
        templateUrl: "app/views/manage-modules.html"
        controller: "ManageModulesCtrl"
      .when "/admin",
        templateUrl: "app/views/admin.html"
        controller: "AdminCtrl"
      .otherwise
        redirectTo: "/"

