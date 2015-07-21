#compile with coffee -cw controller.coffee

app = angular.module 'app', []

app.controller 'controller', ['$scope', '$location', '$anchorScroll', '$http', ($scope, $location, $anchorScroll, $http) ->
    $scope.data =
      appTitle: "VJApp",
      appSlogan: "The 'Back-To-Basics' VJing Software"
      addUserUrl: "http://localhost:5858/newUser"

    $scope.form = {
      username: ''
      email:''
    }

    $scope.emailPattern = /^[a-z]+[a-z0-9._]+@[a-z]+\.[a-z.]{2,5}$/;

    $scope.slides = [
      {
        id: "intro",
        slide: "html/slide1.html",
        image: "images/backgrounds/slide1.jpg"
      },
      {
        id: "overview",
        slide: "html/slide2.html",
        image: "images/backgrounds/slide2.jpg"
      },
      {
        id: "download",
        slide: "html/slide3.html",
        image: "images/backgrounds/slide3.jpg"
      }

    ]

    $scope.jumpToSlide = (id) ->
      $location.hash(id)
      $anchorScroll()
      return;


    $scope.addUser = () ->
      #console.log 'email', $scope.form.email
      #console.log 'username', $scope.form.username

      #if typeof $scope.form.email == 'undefined'

      if $scope.form.username == ''
        angular.element('#nameField').popover('show');
        return

      #if $scope.form.email == ''
      if typeof $scope.form.email == 'undefined'
        angular.element('#emailField').popover('show');
        return


      dataToPost = {
        username: $scope.form.username,
        email: $scope.form.email
        }
      #dataToPost = JSON.stringify(dataToPost);
      console.log dataToPost

      req =
        method: 'POST'
        url: $scope.data.addUserUrl,
        headers:
          'Content-Type': undefined

        data: dataToPost

      #$http.get($scope.data.addUserUrl, dataToPost).success((data, status, headers, config) ->
      $http(req).success((data, status, headers, config) ->
        console.log "success"
        console.log data
        console.log status
        #console.log headers
        #console.log config
        return
      ).error((data, status, headers, config) ->
        console.log "error"
        console.log data
        console.log status
        #console.log headers
        #console.log config
        return
      )
      return
    return
];


app.directive('downloadButton', ["$location","$anchorScroll",($location, $anchorScroll) ->
  return {
    restrict: 'E',
    scope: {
      jumpto: '@'
    },

    templateUrl: 'html/partials/buttonTemplate.html',
    link: (scope, element, attrs) ->
      console.log 'test', scope.jumpto

      element.on('click', (event) ->
          #console.log event
          $location.hash(scope.jumpto)
          $anchorScroll()
          return;
      )
  }
])
