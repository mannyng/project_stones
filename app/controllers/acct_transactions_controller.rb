# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# acct_transactions_controller.rb

# This controller contains methods for AcctTransaction objects
class AcctTransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_acct_transaction, only: [:show, :edit, :update, :destroy]

  # GET /acct_transactions
  # GET /acct_transactions.json
  def index
    @acct_transactions = AcctTransaction.all
  end

  # GET /acct_transactions/1
  # GET /acct_transactions/1.json
  def show
    @account = Account.find(@acct_transaction.account_id)
    #@recipient = Account.find(@acct_transaction.recipient_acct)
    if @acct_transaction.wire_transfers.present?
    @wire_transfer = @acct_transaction.wire_transfers.find_by_acct_transaction_id(params[:id])    
   end
  end

  # GET /acct_transactions/new
  def new
      @acct_transaction = AcctTransaction.new
      @acct_transaction.id = SecureRandom.random_number(99999999999999)
      @acct_transaction.account_id = params[:account_id]
      @acct_transaction.date = Time.now
      @acct_transaction.transaction_type_id = params[:transaction_type_id]
      @acct_transaction.amount = params[:amount]
      @wire_transfer = @acct_transaction.wire_transfers.new
    # for the view - show 'name' of transaction types
    @trans_type = TransactionType.find(params[:transaction_type_id]).name
  end

  # GET /acct_transactions/1/edit
  def edit
  end

  # POST /acct_transactions
  # POST /acct_transactions.json
  def create
    @acct_transaction = AcctTransaction.new(acct_transaction_params)
    @acct_transaction.id = SecureRandom.random_number(99999999999999)
    @acct_transaction.date = Time.now
    #@wire_transfer = @acct_transaction.wire_transfers.build
    #@acct_transaction.wire_transfers.routing = params[:routing]
    if @acct_transaction.valid?
    adjust_balance
    end
 
    respond_to do |format|
      if @acct_transaction.save
        modify_acct_balance
        logger.info "Transaction was just created"
        format.html { redirect_to @acct_transaction, notice: 'Acct transaction was successfully created.' }
        format.json { render :show, status: :created, location: @acct_transaction }
      else
        # flash[:error] = @acct_transaction.errors
        format.html { redirect_to new_account_acct_transactions_path(@acct_transaction.account_id, :transaction_type_id => @acct_transaction.transaction_type_id), :flash => { :alert => "INSUFFICIENT FUNDS!! Check balance and try again" } }
        format.json { render json: @acct_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acct_transactions/1
  # PATCH/PUT /acct_transactions/1.json
  def update
    respond_to do |format|
      if @acct_transaction.update(acct_transaction_params)
        format.html { redirect_to @acct_transaction, notice: 'Acct transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @acct_transaction }
      else
        format.html { render :edit }
        format.json { render json: @acct_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acct_transactions/1
  # DELETE /acct_transactions/1.json
  def destroy
    @acct_transaction.destroy
    respond_to do |format|
      format.html { redirect_to acct_transactions_url, notice: 'Acct transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acct_transaction
      @acct_transaction = AcctTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acct_transaction_params
      params.require(:acct_transaction).permit(:account_id, :recipient_acct, :transaction_type_id, :description, :amount, :adjusted_bal, wire_transfers_attributes:[:id, :acct_transaction_id, :routing])
    end
    

  public
    def modify_acct_balance
      @account = Account.find(@acct_transaction.account_id)
     #@recipient = Account.find(@acct_transaction.recipient_acct)
   case @acct_transaction.transaction_type_id
    when 1,2,4,5,7
        @account.update_attributes!(balance: account.balance - @acct_transaction.amount)
    when 3,6,8
     @recipient = Account.find(@acct_transaction.recipient_acct)
     ActiveRecord::Base.transaction do
      @account.update(balance: @account.balance - @acct_transaction.amount)
      @recipient.update(balance: @recipient.balance + @acct_transaction.amount)
     end
       when 9
        ActiveRecord::Base.transaction do
      @account.update(balance: @account.balance - @acct_transaction.amount)
       #@wire_transfer = WireTransfer.new(routing: params[:routing])
      #@wire_transfer.save!
      end
    end
  end
    def adjust_balance
      case @acct_transaction.transaction_type_id
          when 1,2,3,4,5,7
            @acct_transaction.adjusted_bal = Account.find(@acct_transaction.account_id).balance - @acct_transaction.amount
          when 6,8
            @acct_transaction.adjusted_bal = Account.find(@acct_transaction.account).balance - @acct_transaction.amount
          when 9
          @acct_transaction.adjusted_bal = Account.find(@acct_transaction.account).balance - @acct_transaction.amount
      end
    end
end
