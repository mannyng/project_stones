class RecipientDetailsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_recipient_detail, only: [:show, :edit, :update, :destroy]

  # GET /acct_transactions
  # GET /acct_transactions.json
  def index
    @recipient_detail = RecipientDetail.all
  end

  # GET /acct_transactions/1
  # GET /acct_transactions/1.json
  def show
    @account = Account.find(@recipient_detail.account_id)
    #@recipient = RecipientDetail.find_by(:bank_account)
  end

  # GET /acct_transactions/new
  def new
      @recipient_detail = RecipientDetail.new
      @recipient_detail.id = SecureRandom.random_number(99999999999999)
      @recipient_detail.account_id = params[:account_id]
      @recipient_detail.bank_account = params[:bank_account]
      @recipient_detail.date = Time.now
      @recipient_detail.transaction_type_id = params[:transaction_type_id]
      @recipient_detail.amount = params[:amount]
    # for the view - show 'name' of transaction types
    @trans_type = TransactionType.find(params[:transaction_type_id]).name
  end

  # GET /acct_transactions/1/edit
  def edit
  end

  # POST /acct_transactions
  # POST /acct_transactions.json
  def create
    @recipient_detail = RecipientDetail.new(recipient_detail_params)
    @recipient_detail.id = SecureRandom.random_number(99999999)
    @recipient_detail.date = Time.now
    adjust_balance

    respond_to do |format|
      if @recipient_detail.save
        modify_acct_balance
        logger.info "Transaction was just created"
        format.html { redirect_to @recipient_detail, notice: 'Acct transaction was successfully created.' }
        format.json { render :show, status: :created, location: @recipient_detail }
      else
        # flash[:error] = @recipient_detail.errors
        format.html { redirect_to new_account_acct_transactions_path(@recipient_detail.account_id, :transaction_type_id => @recipient_detail.transaction_type_id), :flash => { :alert => "INSUFFICIENT FUNDS!! Check balance and try again" } }
        format.json { render json: @recipient_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acct_transactions/1
  # PATCH/PUT /acct_transactions/1.json
  def update
    respond_to do |format|
      if @recipient_detail.update(@recipient_detail_params)
        format.html { redirect_to @recipient_detail, notice: 'Acct transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipient_detail }
      else
        format.html { render :edit }
        format.json { render json: @recipient_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acct_transactions/1
  # DELETE /acct_transactions/1.json
  def destroy
    @recipient_detail.destroy
    respond_to do |format|
      format.html { redirect_to acct_transactions_url, notice: 'Wire transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipient_detail
      @recipient_detail = RecipientDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipient_detail_params
      params.require(:recipient_detail).permit(:account_id, :transaction_type_id, :description, :amount, :bank_account, :recipient_name, :address, :city, :state, :country, :phone, :bank_name, :bank_country, :routing)
    end
    

  public
    def modify_acct_balance
      @account = Account.find(@recipient_detail.account_id)
     #@recipient = Account.find(@acct_transaction.recipient_acct)
   case @recipient_detail.transaction_type_id
    when 1,2,4,5,7
        @account.update_attributes!(balance: account.balance - @recipient_detail.amount)
    when 3,6,8
     @recipient = Account.find(@recipient_detail.bank_account)
     ActiveRecord::Base.transaction do
      @account.update(balance: @account.balance - @recipient_detail.amount)
      @recipient.update(balance: @recipient.balance + @acct_transaction.amount)
     end
     when 9
       ActiveRecord::Base.transaction do
        @account.update(balance: @account.balance - @recipient_detail.amount)
       end
   end
 end
    def adjust_balance
      case @recipient_detail.transaction_type_id
          when 1,2,3,4,5,7
            @recipient_detail.adjusted_bal = Account.find(@recipient_detail.account_id).balance - @recipient_detail.amount
          when 9,6,8
            @recipient_detail.adjusted_bal = Account.find(@recipient_detail.account).balance - @recipient_detail.amount
      end
    end
end
