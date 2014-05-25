class CommentsController < ApplicationController

  def create
    comment = Comment.new(params[:comment])
    comment.request_ip = request.remote_ip

    if comment.spam?
      render json: {text: I18n.t('navbar.comment.thank_you')}
    elsif comment.save
      Mailer.comment(comment).deliver
      render json: {text: I18n.t('navbar.comment.thank_you')}
    else
      render json: {text: I18n.t('navbar.comment.problem')}
    end
  end
end
