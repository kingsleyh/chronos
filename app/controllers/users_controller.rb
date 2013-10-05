class UsersController < ApplicationController

  before_filter :authenticate_user!, :admin_only

  layout 'chronos_layout'

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def settings
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    @timesheets = Timesheet.where(:user_id => @user.id)
  end

  def update_settings
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated user settings."
      redirect_to root_path
    end
  end

  def create_user
      @user = User.new(user_params)
      if @user.save
        # success
        redirect_to :users
      else
        # error handling
        render new_user_path
      end
    end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated user."
      redirect_to :users
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to :users
    end
  end


  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 :current_password,
                                 {:authorised_tasks => []},
                                 :default_task,
                                 :active,
                                 :admin
    )
  end


end
