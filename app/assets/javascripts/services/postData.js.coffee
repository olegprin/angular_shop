angular.module('Blog').factory('postData',['$http', ($http) ->
  
  postData =
    data:
      posts: [{title: 'Loading...', discription: ''}]
    isLoaded: false
  

  postData.loadDatas = ->
    if !postData.isLoaded
      $http.get('./data.json').success( (data) ->
        postData.data.posts = data
        postData.isLoaded=true
        console.log('Successfully loaded posts.')
      ).error( ->
        console.error('Failed to load posts.')
      )

  return postData
])