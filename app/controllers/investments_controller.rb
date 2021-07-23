class InvestmentsController < ApplicationController
  before_action :set_investment, only: %i[show edit update destroy]
  before_action :authenticated, only: %i[edit update destroy home show new index]

  # GET /investments or /investments.json
  def index
    @investments = Investment.all
  end

  def index_external
    @investments = Investment.all
  end

  # GET /investments/1 or /investments/1.json
  def show; end

  # GET /investments/new
  def new
    @investment = Investment.new
  end

  # GET /investments/1/edit
  def edit; end

  # POST /investments or /investments.json
  def create
    @investment = Investment.new(investment_params)
    @investment.group_id = Group.all.where('name = ?', params['investment']['group_id']).select(:id).first.id

    @investment.user_id = current_user.id

    respond_to do |format|
      if @investment.save
        format.html { redirect_to @investment, notice: 'Investment was successfully created.' }
        format.json { render :show, status: :created, location: @investment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investments/1 or /investments/1.json
  def update
    respond_to do |format|
      if @investment.update(investment_params)
        format.html { redirect_to @investment, notice: 'Investment was successfully updated.' }
        format.json { render :show, status: :ok, location: @investment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investments/1 or /investments/1.json
  def destroy
    @investment.destroy
    respond_to do |format|
      format.html { redirect_to investments_url, notice: 'Investment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  helper_method :logged_in?

  def logged_in?
    !current_user.nil?
  end

  def authenticated
    return if logged_in?

    flash[:alert] = 'You need to login or sign up to access'
    redirect_to '/login'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_investment
    @investment = Investment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def investment_params
    params.require(:investment).permit(:crypto, :amount, :user_id)
  end
end
