class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
  skip_before_action :require_no_authentication, only: [:new, :create]
  
  def new
     super
   end 
  # Inhreit content of create method from parent
  def create
     super
  end
   # if !verify_recaptcha
    #  flash.delete :recaptcha_error
     # build_resource(sign_up_params)
     # resource.valid?
     # resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
     # respond_with_navigational(resource) { render :new }
    #else
     # flash.delete :recaptcha_error
      #super
    #end
  #end
  # Route new users to their "customer" page after registration
  #def after_sign_up_path_for(resource)
   # new_user_customers_path(current_user)
  #end
  
    private
  def redirect_unless_admin
    unless admin?
      flash[:error] = "Only admins can do that"
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end
end
