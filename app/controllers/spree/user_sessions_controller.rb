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

  def create
    authenticate_refinery_user!

    if refinery_user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = t(:logged_in_succesfully)
          redirect_back_or_default(after_sign_in_path_for(current_refinery_user))
        }
        format.js {
          render :json => {:ship_address => current_refinery_user.ship_address,
                           :bill_address => current_refinery_user.bill_address}.to_json
        }
      end
    else
      respond_to do |format|
        format.html {
          flash.now[:error] = t('devise.failure.invalid')
          render :new
        }
        format.js {
          render :json => {:error => t('devise.failure.invalid')}
        }
      end
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