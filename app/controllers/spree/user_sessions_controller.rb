class Spree::UserSessionsController < Devise::SessionsController
  include SslRequirement
  helper 'spree/base'
  if defined?(Spree::Dash)
    helper 'spree/analytics'
  end

  include Spree::Core::ControllerHelpers

  ssl_required :new, :create, :destroy, :update
  ssl_allowed :login_bar

  # GET /resource/sign_in
  def new
    @user = Refinery::User.new
    #super
  end

  def create
    authenticate_user!

    if user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = t(:logged_in_succesfully)
          redirect_back_or_default(after_sign_in_path_for(spree_current_user))
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