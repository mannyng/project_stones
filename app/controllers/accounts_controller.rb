# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# accounts_controller.rb

# This controller contains method pertaining to Account objects
class AccountsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_filter :user_owns_account?

  # GET /accounts
  # GET /accounts.json
  def index
    @user = current_user
    @accounts = @user.accounts

  end

  # Admins must have access to ALL account data
  def adminview
    @accounts = Account.all

    respond_to do |format|
      format.html # adminview.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    # criteria from the "Search by" select menu
    if params[:search]
        case (params[:search_criteria])
        when '1'
          @criteria = 'id'
        when '2'
          # Using Dynamic attribute-based finders to lookup by non-ID field
          # Wrapped in a rescue block to avert user typo errors
          begin
              @type_id = TransactionType.find_by_name("#{params[:search].downcase}").id
          rescue
              @acct_transactions = nil
              @table_heading = "Transaction Search Results"
          end
            @criteria = 'transaction_type_id'
            @acct_transactions = @account.acct_transactions.where("#{@criteria} LIKE ?", "#{@type_id}").page(params[:page]).per(15)
            @table_heading = "Listing All Transactions"
            return
        when '3' 
          @criteria = 'description'
        end
        @acct_transactions = @account.acct_transactions.where("#{@criteria} LIKE ?", "%#{params[:search].downcase}%").page(params[:page]).per(15)
        @table_heading = "Transaction Search Results"
    else
    @acct_transactions = @account.acct_transactions.all.order('date DESC').page(params[:page]).per(15)
    @table_heading = "Listing All Transactions"
    
    end
    
  end

  # GET /accounts/new
  def new
    # @user = User.find(params[:user_id])
    @account = Account.new
    @account.id = SecureRandom.random_number(999999999999)
    @account.customer_id = current_user.customer.id
    @account.balance = 0
    @account.date_opened = Time.now.to_date

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @account.id = SecureRandom.random_number(999999999999)
    @account.customer_id = current_user.customer.id
    @account.balance = 0
    @account.date_opened = Time.now.to_date

    respond_to do |format|
      if @account.save
        if current_user.accounts.count > 1
          format.html { redirect_to accounts_path(current_user), notice: 'CONGRATULATIONS, your new account was successfully created!' }
          format.json { render :show, status: :created, location: @account }
        else
        format.html { redirect_to new_user_addresses_path(current_user), notice: 'Great! Just one more step..' }
        format.json { render :show, status: :created, location: @account }
        end
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    if admin?
    @account.destroy
   
      respond_to do |format|
      
         format.html { redirect_to manage_accounts_administrator_path(current_user, format: :html), notice: 'Account was successfully destroyed.' }
        format.json { head :no_content }
       #else
       #  format.json { head :no_content }
       #  format.html { redirect_to accounts_path(current_user), notice: 'Account was successfully destroyed.' }
      end
       
       else 
         respond_to do |format| 
           format.html { redirect_to :back, notice: 'Contact your relationship manager for action.'}
           format.json { head :no_content }
          end
       end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:acct_type_id)
    end

    # User may only access their own account(s), unless they are admin
    def user_owns_account?
      if @account
        @account.customer.user_id == current_user.id || current_user.role == 'admin'
      end
    end
end
