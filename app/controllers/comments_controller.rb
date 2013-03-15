class CommentsController < Admin::ApplicationController

  def create
    comment = Comment.new(params[:comment])

    if comment.save
      Mailer.comment(comment).deliver
      render json: {text: I18n.t('navbar.comment.thank_you')}
    else
      render json: {text: I18n.t('navbar.comment.problem')}
    end
  end
end
