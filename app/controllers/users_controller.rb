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
      flash[:message] = user.errors.full_messages
    end

    redirect_to :back
  end

  private
  def permitted_params
    params.require(:user).permit(:first_name, :last_name, :gender, :city, :birthdate, :avatar )
  end

  def render_default
    render :main
  end

end
