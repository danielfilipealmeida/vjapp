var app;

app = angular.module('app', []);

app.controller('controller', [
  '$scope', '$location', '$anchorScroll', '$http', function($scope, $location, $anchorScroll, $http) {
    $scope.data = {
      appTitle: "VJApp",
      appSlogan: "The 'Back-To-Basics' VJing Software",
      addUserUrl: "http://localhost:5858/newUser"
    };
    $scope.form = {
      username: '',
      email: ''
    };
    $scope.emailPattern = /^[a-z]+[a-z0-9._]+@[a-z]+\.[a-z.]{2,5}$/;
    $scope.slides = [
      {
        id: "intro",
        slide: "html/slide1.html",
        image: "images/backgrounds/S4.png"
      }, {
        id: "overview",
        slide: "html/slide2.html",
        image: "images/backgrounds/S3.png"
      }, {
        id: "download",
        slide: "html/slide3.html",
        image: "images/backgrounds/S1.jpg"
      }
    ];
    $scope.jumpToSlide = function(id) {
      $location.hash(id);
      $anchorScroll();
    };
    $scope.addUser = function() {
      var dataToPost, req;
      if ($scope.form.username === '') {
        angular.element('#nameField').popover('show');
        return;
      }
      if (typeof $scope.form.email === 'undefined') {
        angular.element('#emailField').popover('show');
        return;
      }
      dataToPost = {
        username: $scope.form.username,
        email: $scope.form.email
      };
      console.log(dataToPost);
      req = {
        method: 'POST',
        url: $scope.data.addUserUrl,
        headers: {
          'Content-Type': void 0
        },
        data: dataToPost
      };
      $http(req).success(function(data, status, headers, config) {
        console.log("success");
        console.log(data);
        console.log(status);
      }).error(function(data, status, headers, config) {
        console.log("error");
        console.log(data);
        console.log(status);
      });
    };
  }
]);

app.directive('downloadButton', [
  "$location", "$anchorScroll", function($location, $anchorScroll) {
    return {
      restrict: 'E',
      scope: {
        jumpto: '@'
      },
      templateUrl: 'html/partials/buttonTemplate.html',
      link: function(scope, element, attrs) {
        console.log('test', scope.jumpto);
        return element.on('click', function(event) {
          $location.hash(scope.jumpto);
          $anchorScroll();
        });
      }
    };
  }
]);
