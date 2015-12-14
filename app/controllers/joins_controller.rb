class JoinsController < ApplicationController
  before_action :authenticate_user

  def create
    join = Join.new
    idea = Idea.find params[:idea_id]
    join.idea = idea
    join.user = current_user
    if can? :manage, join
      if join.save
      redirect_to ideas_path, notice: "Lulz thanks for joining"
      else
      redirect_to ideas_path, alert: "Can't Join Already a Member"
      end
    else
      redirect_to ideas_path, alert: "Can't Join your own Idea"
    end
  end

  def destroy
    idea = Idea.find params[:idea_id]
    join     = current_user.joins.find params[:id]
    join.destroy
    redirect_to ideas_path, notice: "Join removed!"
  end




end
