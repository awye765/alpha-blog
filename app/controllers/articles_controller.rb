class ArticlesController < ApplicationController
    
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    # Before taking any action, it sets article per the set_article method
    # and only applies that article setting to the edit, update, show
    # and destroy methods.
    
    before_action :require_user, except: [:index, :show]
    # Restriction #1 - requires a logged in user for all actions except 
    # index and show.  This prevents logged out users or non-users from
    # acessing the create, edit, update and delete actions by typing in the
    # relevant url path.
    
    before_action :require_same_user, only: [:edit, :update, :destroy]
    # Restriction #2 - requires the logged in user that created the article
    # for the edit, update and destroy actions.  This prevents other logged in
    # users from deliberately/inadvertently messing up another user's articles.
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)    
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
        @article.user = current_user
        
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

        def require_same_user
            if current_user != @article.user and !current_user.admin?
                flash[:danger] = "You can only edit or delete your own articles"
                redirect_to root_path
            end
        end
    
end
