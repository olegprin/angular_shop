angular.module('Blog').factory('postData', ['$http',  '$location', '$q', ($http, $location, $q) ->

 
  postData=
    data:
      products: [{title: 'Loading posts...', contents: ''}]
  
    login: (email, password) ->
      $http.post('/api/sessions', user:
        email: email
        password: password).then (response) ->
        postData.currentUser = response.data.user
        if postData.isAuthenticated()
          #$location.path(response.data.redirect);
          $location.path '/record'
        return
    logout: (redirectTo) ->
      $http.delete('/api/sessions').then (response) ->
        $http.defaults.headers.common['X-CSRF-Token'] = response.data.csrfToken
        postData.currentUser = null
        redirect redirectTo
        return
      return
    
   

    register: (email, password, confirm_password) ->
      $http.post('./api/users.json', user:
        email: email
        password: password
        password_confirmation: confirm_password).then (response) ->
        postData.currentUser = response.data
        if postData.isAuthenticated()
          $location.path '/record'
        return
    requestCurrentUser: ->
      if postData.isAuthenticated()
        $q.when postData.currentUser
      else
        $http.get('/api/users').then (response) ->
          postData.currentUser = response.data.user
          postData.currentUser
    currentUser: null

    isAuthenticated: ->
      !!postData.currentUser

  redirect = (url) ->
    url = url or '/'
    $location.path url
    return


  postData.loadPost = ->
    $http.get('./data.json').success( (data) ->
      postData.data.products = data
      console.log('Successfully loaded posts.')
    ).error( ->
      console.error('Failed to load posts.')
    )        

   
  postData.createPost=(newPost)->
    if newPost.newProductTitle==" " or newPost.newProductContents==" "
      alert "Bida"
      return false  
    
    data=
      products:
        title: newPost.newProductTitle
        description: newPost.newProductContents
    
    $http.post('./products.json', data).success( (data) ->
      postData.data.products.push(data)
      console.log('Successfully loaded posts.')
    ).error( ->
      console.error('Failed to load posts.')
    )    

  postData.deletePost = (value) ->
    $http.delete('/products/' + value + '.json').success((data)->
      data=
        products:
          title: " "
          description: " "
      
      postData.data.products.splice(1, 1)
      alert("Comments was deleted")
    )

  postData.updatePost=(value, post)->
    if post.newProductTitle==" " or post.newProductContents==" "
      alert "Bida"
      return false  
    
    data=
      products:
        title: post.newProductTitle
        description: post.newProductContents
    
    $http.put('/products/' + value + '.json', data).success( (data) ->
      postData.data.products.push(data)
      console.log('Successfully loaded posts.')
    ).error( ->
      console.error('Failed to load posts.')
    )   

  return postData  


])