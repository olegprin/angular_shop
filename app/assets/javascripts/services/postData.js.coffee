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
      alert("Comments was deleted")
    )



  postData.editPost = (value) ->
    post=_.findWhere(postData.data.products, {id: parseInt(value)})
    
    postData:
      data:
        products:
          title: post.title 
          description: post.description    

  return postData

])