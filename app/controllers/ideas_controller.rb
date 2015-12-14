class IdeasController < ApplicationController

  before_action :authenticate_user, except: [:index, :show]
  before_action :find_idea, only: [:show, :destroy, :edit, :update]
  before_action :authorize, only: [:edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    idea_params = params.require(:idea).permit([:title, :body])
    @idea = Idea.new(idea_params)
    @idea.user = current_user
    if @idea.save
      redirect_to ideas_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def destroy
    @idea.destroy
      flash[:notice] = "Idea deleted successfully"
      redirect_to ideas_path
  end

  def edit
    redirect_to ideas_path, alert: "Access denied!" unless can? :manage, @idea

  end

  def update
    idea_params = params.require(:idea).permit([:title, :body])
    if @idea.update(idea_params)
      redirect_to(idea_path(@idea))
    else
      render :edit
    end
  end

  def index
    @idea = Idea.all.order("created_at DESC") 
  end

  private

    def find_idea
      @idea = Idea.find params[:id]
    end

    def authorize
      redirect_to ideas_path, alert: "Access denied!" unless can? :manage, @idea
    end

end
