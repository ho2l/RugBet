class CommentsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @comment = @game.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to game_path(@game)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end