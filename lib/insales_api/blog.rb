module InsalesApi
  	class Blog < Base
	
		def articles
			InsalesApi::Article.all(params: { blog_id: id } )
    	end

	end
end
