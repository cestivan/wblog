class CommentsController < ApplicationController
  layout false

  def create
    cookies[:name] = comment_params[:name]
    cookies[:email] = comment_params[:email]

    @post = Post.find( params[:blog_id] )
    @comments = @post.comments.order(created_at: :desc)

    @comment = @post.comments.build(comment_params)
    if @comment.save
      flash.now[:notice] = '发表成功'
      # 重置评论
      @comment = Comment.new
    else
      if @comment.errors[:content]&.include?('contains sensitive word')
        flash.now[:error] = '评论包含敏感词,请修改后重试'
        render status: 422
      end
    end
  end

  def refresh
    @post = Post.find(params[:blog_id])
    @comments = @post.comments.order(created_at: :desc)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :name, :email)
  end
end