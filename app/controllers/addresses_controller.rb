# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# addresses_controller.rb

# This controller contains methods for Address objects

class AddressesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_address, only: [:show, :destroy]
 before_action :set_address_edit, only: [:edit, :update]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
    #@address.customer_id = current_user.customer.id
    @address.customer_id = params[:customer_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(address_params)
    #@address.customer_id = current_user.customer.id
    #@address.customer_id = params[:customer_id]

    respond_to do |format|
      if @address.save
        format.html { redirect_to manage_customers_administrator_path(:id => current_user.id),  notice: 'Awesome!, you created mailing address for the customer' }
          #format.html { redirect_to accounts_path(current_user), notice: 'CONGRATULATIONS, your new account was successfully created!' }
          format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end
    def set_address_edit      
     @address = Address.find(params[:customer_id])
     rescue ActiveRecord::RecordNotFound
     flash[:notice] = "Customer has no address in the system"
     redirect_to :action => 'new'
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:customer_id, :address1, :address2, :zip_code_zip_code)
    end
end
