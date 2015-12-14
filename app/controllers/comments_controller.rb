class CommentsController < ApplicationController
before_action :authenticate_user, only: [:create, :destroy]

  def create
    comment_params    = params.require(:comment).permit(:body)
    @idea               = Idea.find params[:idea_id]
    @comment = Comment.new(comment_params)
    @comment.idea = @idea
    if @comment.save
      redirect_to idea_path(@idea), notice: "Comment created successfully!"
    else
      render "ideas/show"
    end
  end

  def destroy
    comment = Comment.find params[:id]
    comment.destroy
    redirect_to question_path(comment.question), notice: "Answer deleted"
  end




end
