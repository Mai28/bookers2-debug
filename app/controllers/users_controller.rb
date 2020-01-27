class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_current_user, {only: [:edit,:update,:destroy]}

    def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    end

    def index
    @users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
    @books = Book.all
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
     @user = current_user
    end

    def edit
    @user = User.find(params[:id])
    end

    def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user), notice: "successfully updated user!"
    else
    render "edit"
    end
  end

    private

    def book_params
        params.require(:book).permit(:title, :body)
    end


    def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
    end

   def  ensure_current_user
        @user = User.find(params[:id])
     if @user.id != current_user.id
        redirect_to user_path(current_user.id)
     end
   end
end

