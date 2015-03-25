angular.module "modulmanager"
  .controller "MainCtrl", ($scope,$rootScope) ->
    $rootScope.pageTitle = 'Modulmanager'
    $scope.navOpts = [
      {
        'title': 'View Structure',
        'url': 'semester-view',
        'description': 'New to this study? Want to get a quick look at what it\'s all about? You\'re perfectly right here!',
        'logo': 'topconfig-logo.png'
        'rank':1
      },
      {
        'title': 'View single module',
        'url': 'modules',
        'description': 'If you\'re looking for more details of a single module, this is the place for you!',
        'logo': 'icon-hourglass.png'
        'rank':2
      }
    ]
