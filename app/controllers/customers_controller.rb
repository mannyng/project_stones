# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# customers_controller.rb

# This controller contains methods for Customer objects
class CustomersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    if @customer.address.present?
    zip = @customer.address.zip_code_zip_code
    @city = ZipCode.find(zip).city
    @state = ZipCode.find(zip).state_abbreviation
   else
    redirect_to new_customer_address_path(:customer_id => @customer.id), notice: 'This customer has no address in the file'
   end
  end

  # GET /customers/new
  def new

    @customer = Customer.new
    @customer.id = SecureRandom.random_number(999999999) # 9-digit integer
    @customer.user_id = current_user.id
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @customer.id = SecureRandom.random_number(999999999) # 9-digit integer
    @customer.user_id = current_user.id
    
    respond_to do |format|
      if @customer.save
        format.html { redirect_to new_user_accounts_path(current_user), notice: 'Okay, we\'re half way there!' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to adminview_administrator_path, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:title, :firstname, :lastname, :phone1, :phone2, address_attributes:[:id, :customer_id, :address1, :address2, :zip_code_zip_code])
    end
end
