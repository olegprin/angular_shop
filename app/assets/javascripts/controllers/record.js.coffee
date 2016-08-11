Blog.controller('RecordCtrl', [
  '$scope', 'Session', 'Records'
  ($scope, Session, Records) ->

    $scope.user = Session.requestCurrentUser()
    $scope.records = Records.index()

    $scope.logout = ->
      Session.logout()
      return

 
])