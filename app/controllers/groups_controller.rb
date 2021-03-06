class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :authenticated, only: %i[edit update show destory new index]

  # GET /groups or /groups.json
  def index
    @groups = Group.all.includes(investments: [:user])
  end

  # GET /groups/1 or /groups/1.json
  def show
    @investments = Investment.includes(:user).where('user_id = ? AND group_id = ?', current_user.id, @group.id)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
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
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :user_id, :icon)
  end
end
