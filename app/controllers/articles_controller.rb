class ArticlesController < ApplicationController
    
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    # Before taking any action, it sets article per the set_article method
    # and only applies that article setting to the edit, update, show
    # and destroy methods.
    
    def index
        @articles = Article.all    
    end
    
    def new
        @article = Article.new
        # This does ...
    end
    
    def edit
        #@article = Article.find(params[:id])
    end
    
    def create
        
        @article = Article.new(article_params)
        
        if @article.save
            flash[:success] = "Article was successfully created"
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
      #@article = Article.find(params[:id])
      if @article.update(article_params)
          flash[:success] = "Article was successfully updated"
          redirect_to article_path(@article)
      else
          render 'edit'
      end
     
    end
    
    def show
        #@article = Article.find(params[:id])
    end
    
    def destroy
        #@article = Article.find(params[:id])
        @article.destroy
        flash[:danger] = "Article was successfully deleted"
        redirect_to articles_path
    end
    
     private
        def set_article
            @article = Article.find(params[:id])
        end
        
        def article_params
            params.require(:article).permit(:title, :description)
        end

end
