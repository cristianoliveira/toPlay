class UsersController < ApplicationController

  def profile
    @user = current_user
    render_default
  end

  def uploads
    render_default
  end

  def notifications
    render_default
  end

  def update
    current_user.update(permitted_params)

    if current_user.save
      flash[:message] = 'Atualizado com sucesso!'
    else
      flash[:message] = current_user.errors.full_messages
    end

    redirect_to :back
  end

  def read_notification
    notification = current_user.notifications.find(params[:id])
    notification.read = true;
    notification.save

    if notification.url
      redirect_to notification.url
    else
      redirect_to :back
    end
  end

  private
  def permitted_params
    params.require(:user).permit(:first_name, :last_name, :gender, :city, :birthdate, :avatar )
  end

  def render_default
    render :main
  end

end
