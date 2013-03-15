class Admin::CommentsController < Admin::ApplicationController
  load_resource :only => [:destroy]
  authorize_resource class: Comment

  def index
    @comments = Comment.order('id DESC').page(params[:page])
  end

  def destroy
    @comment.destroy

    redirect_to admin_comments_url, :notice => "Successfully destroyed comment."
  end

end
