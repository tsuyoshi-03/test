class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
    @comment = current_user.comments.new
  end  
  
  def edit
    @topic = Topic.find(params[:id])
  end 

  def update
     @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :edit
    end
  end  
  
  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      redirect_to topics_path
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
  
end
