class ArticlesController < ApplicationController
    def new
        @article = Article.new
        # This does ...
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def create
        
        @article = Article.new(article_params)
        
        if @article.save
            flash[:notice] = "Article was successfully created"
            # Alerts the user that their post was successfully created
            redirect_to article_path(@article)
            # Redirects ...
            
        else
            render 'new'
            # If the validation of input fails, it will render a new template
            # to allow the user to try again,
        end
    
    end
    
    def update
      @article = Article.find(params[:id])
      if @article.update(article_params)
          flash[:notice] = "Article was successfully updated"
          redirect_to article_path(@article)
      else
          render 'edit'
      end
     
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
     private
    
        def article_params
            params.require(:article).permit(:title, :description)
        end

end
