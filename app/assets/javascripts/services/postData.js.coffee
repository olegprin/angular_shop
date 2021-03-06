angular.module('Blog').factory('postData', ['$http', ($http) ->

 
  postData=
    data:
      products: [{title: 'Loading posts...', contents: ''}]
    
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