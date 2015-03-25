angular.module "modulmanager"
  .controller "AdminCtrl", ($scope, $rootScope) ->
    
    $rootScope.pageTitle = 'admin section - Modulmanager'
    $scope.adminCards = [
      {
        title:'View module'
        description:'Description'
        url:'url'
        logo:'icons/icon-pass.png'
      }
      {
        title:'Manage Modules'
        description:'See all modules in a huge list and directly edit it'
        url:'manage-modules'
        logo:'images/topconfig-logo.png'
      }
    ]
