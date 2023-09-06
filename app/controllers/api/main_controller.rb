class Api::MainController < ApplicationController
  def index
    puts "api/index----------------"
    render json: { result: "success" , blogs: mains}
  end

  def show
  end

  def create
    puts "create------------------"
    main = Blog.new(main_params)
    if main.save
      render json: { result: "success" , blogs: mains} 
    end
  end

  def update
    puts "update------------------"
    main = Blog.find(params[:id])
    if main.update(main_params)
      render json: { result: "success" , blogs: mains}
    end  
  end
  
  def destroy
    puts "destroy-----------------"
    main = Blog.find(params[:id])
    if main.destroy
      render json: { result: "success" , blogs: mains}
    end
  end


private
  def mains
    # main.initialize({test: "test"})
      Blog.order(created_at: :desc)
  end

  def main_params
    params[:main] = params[:blog] if params[:blog]
    params.require(:main).permit(:id, :title, :content, :created_at, :updated_at, :test)  
  end

end
