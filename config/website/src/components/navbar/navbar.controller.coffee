angular.module "modulmanager"
  .controller "NavbarCtrl", ($scope) ->
    $scope.date = new Date()
    $scope.semester = 'Wintersemester 2015'
