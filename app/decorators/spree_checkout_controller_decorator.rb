Spree::CheckoutController.class_eval do
  respond_to :html, :json

  before_filter :check_registration, :except => [:registration, :update_registration]


  def registration
    @user = Refinery::User.new
  end

  def update_registration
    fire_event("spree.user.signup", :order => current_order)
    # hack - temporarily change the state to something other than cart so we can validate the order email address
    current_order.state = 'address'
    if current_order.update_attributes(params[:order])
      redirect_to checkout_path
    else
      @user = Refinery::User.new
      render 'registration'
    end
  end

  private

  def skip_state_validation?
    %w(registration update_registration).include?(params[:action])
  end

  # Introduces a registration step whenever the +registration_step+ preference is true.
  def check_registration
    return unless ::Refinery::Setting.find_or_set(:registration_step, true)
    return if current_refinery_user or current_order.email
    redirect_to spree.checkout_registration_path
  end

  # Overrides the equivalent method defined in Spree::Core.  This variation of the method will ensure that users
  # are redirected to the tokenized order url unless authenticated as a registered user.
  def completion_route
    return order_path(@order) if current_refinery_user
    spree.token_order_path(@order, @order.token)
  end
end