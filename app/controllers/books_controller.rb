class BooksController < ApplicationController
before_action :authenticate_user!
before_action :ensure_current_user, {only: [:edit,:update,:destroy]}
  #(ログインユーザー以外の人が情報を遷移しようとした時に制限をかける)

  def create
    @user = current_user
    @book= Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
      @book.user_id = current_user.id
   if  @book.save #入力されたデータをdbに保存する。
      flash[:notice] = "successfully created book!"#保存された場合の移動先を指定。
      redirect_to book_path(@book.id)

      else
      @books = Book.all
      flash[:notice] = 'errors prohibited this obj from being saved:'
      render :index
      end
  end

  def show
    @user = current_user
  	@book = Book.find(params[:id])
    @book_new = Book.new
  end

  def index
    @user = current_user
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
  end


  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book.id), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
       @books = Book.all
       flash[:notice]= ' errors prohibited this obj from being saved:'
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to "/books", notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end


    def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
    end

  def  ensure_current_user
      @book = Book.find(params[:id])
     if @book.user_id != current_user.id
        redirect_to books_path
     end
  end

end
