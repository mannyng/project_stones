# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# administrators_controller.rb

# This controller contains methods for Administrator objects

class AdministratorsController < ApplicationController
  #call admin layout file
  layout "admin"
  before_filter :authenticate_user!

  before_action :set_administrator, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  # GET /administrators
  # GET /administrators.json
  def index
    @administrators = Administrator.all
  end

  def adminview
      # manage_customers
      # redirect_to manage_customers_administrator_path
      # render "_manage_customers"
  end

  # Update adminview content using AJAX and jQuery
  def manage_accounts
    # criteria from the "Search by" select menu
    if params[:search]
        case (params[:search_criteria])
        when '1'
          @criteria = 'id'
        when '2'
          @criteria = 'customer_id'
        when '3'
          
        # when '3' 
        #   Account.includes(:customers).all
        #   @criteria = 'customer.lastname'
        end

        @accounts = Account.where("#{@criteria} LIKE ?", "%#{params[:search].downcase}%").page(params[:page]).per(15)
        @table_heading = "Account Search Results"
    else
        @accounts = Account.order('id').page(params[:page]).per(15)
        @table_heading = "Listing All Accounts"
    end

    respond_to do |format|
      format.js
      format.html {render 'manage_accounts'}
    end
  end

  def manage_customers
    # criteria from the "Search by" select menu
    if params[:search]
        case (params[:search_criteria])
        when '1'
          @criteria = 'id'
        when '2'
          @criteria = 'lastname'
        end

        @customers = Customer.where("#{@criteria} LIKE ?", "%#{params[:search].downcase}%").page(params[:page]).per(15)
        @table_heading = "Customer Search Results"
    else
        @customers = Customer.order('lastname').page(params[:page]).per(15)
        @table_heading = "Listing All Customers"
    end
    
    respond_to do |format|
      format.js
      format.html {render 'manage_customers'}
    end
  end

  def manage_acct_transactions
    # criteria from the "Search by" select menu
    if params[:search]
        case (params[:search_criteria])
        when '1'
          @criteria = 'id'
        when '2'
          @criteria = 'account_id'
        end

        @acct_transactions = AcctTransaction.where("#{@criteria} LIKE ?", "%#{params[:search].downcase}%").page(params[:page]).per(15)
        @table_heading = "Transaction Search Results"
    else
        @acct_transactions = AcctTransaction.order('date DESC').page(params[:page]).per(15)
        @table_heading = "Listing All Transactions"
        
    end
    
    respond_to do |format|
      format.js
      format.html {render 'manage_acct_transactions'}
    end
  end

  # GET /administrators/1
  # GET /administrators/1.json
  def show
  end

  # GET /administrators/new
  def new
    @administrator = Administrator.new
  end

  # GET /administrators/1/edit
  def edit
  end

  # POST /administrators
  # POST /administrators.json
  def create
    @administrator = Administrator.new(administrator_params)

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to @administrator, notice: 'Administrator was successfully created.' }
        format.json { render :show, status: :created, location: @administrator }
      else
        format.html { render :new }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administrators/1
  # PATCH/PUT /administrators/1.json
  def update
    respond_to do |format|
      if @administrator.update(administrator_params)
        format.html { redirect_to @administrator, notice: 'Administrator was successfully updated.' }
        format.json { render :show, status: :ok, location: @administrator }
      else
        format.html { render :edit }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrators/1
  # DELETE /administrators/1.json
  def destroy
    @administrator.destroy
    respond_to do |format|
      format.html { redirect_to administrators_url, notice: 'Administrator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def require_admin
    unless current_user.role == 'admin'
      redirect_to root_path, alert: 'NOT AUTHORIZED!! Redirecting to home page..'
    end
  end

  def check_referer
    case Rails.application.routes.recognize_path(request.referer)[:controller]
        when 'customers'
          manage_customers
        when 'accounts'
          manage_accounts
        when 'acct_transactions'
          manage_acct_transactions
        else
          manage_accounts
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_params
      params[:administrator]
    end
end
