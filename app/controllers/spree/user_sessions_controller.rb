class Spree::UserSessionsController < Devise::SessionsController
  include SslRequirement
  helper 'spree/base'
  if defined?(Spree::Dash)
    helper 'spree/analytics'
  end

  include Spree::Core::ControllerHelpers

  ssl_required :new, :create, :destroy, :update
  ssl_allowed :login_bar

  layout Refinery::Themes::Theme.default_layout

  # GET /resource/sign_in
  def new
    @user = Refinery::User.new
    super
  end

  #def create
  #  super
  #rescue ::BCrypt::Errors::InvalidSalt, ::BCrypt::Errors::InvalidHash
  #  flash[:error] = t('password_encryption', :scope => 'refinery.users.forgot')
  #  redirect_to refinery.new_refinery_user_password_path
  #end


  def create
    #super
    authenticate_refinery_user!

    if refinery_user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = t(:logged_in_succesfully)
          redirect_back_or_default(after_sign_in_path_for(current_refinery_user))
        }
        format.js {
          user = resource.record
          render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
        }
      end
    else
      flash.now[:error] = t('devise.failure.invalid')
      render :new
    end
  end

  def destroy
    cookies.clear
    session.clear
    super
  end

  private
  def accurate_title
    t(:login)
  end

  def redirect_back_or_default(default)
    redirect_to(session["user_return_to"] || default)
    session["user_return_to"] = nil
  end
end