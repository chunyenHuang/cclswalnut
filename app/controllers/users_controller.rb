class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  helper :headshot
  authorize_resource
  respond_to :html, :json


  def previous
    self.class.first(:conditions => ["id < ?", id], :order => "id desc")
  end

  def next
    self.class.first(:conditions => ["id > ?", id], :order => "id asc")
  end

  ###

  def index
    session[:return_to] = request.referer
    @users = User.order(sort_column + " " + sort_direction).search(params[:search])
  end

  def show
    session[:return_to] = request.referer
    @users = User.find(params[:id],params[:user_id],params[:teacher_id],params[:classlist_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
      #format.pdf { render :layout => false }
      format.pdf do
        pdf = Prawn::Document.new
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
  end

  ###

  def new

  end

  def uploaddocument
    session[:return_to] = request.referer
    @user = User.find(params[:id])
    5.times do
      teacherdocument = @user.teacherdocuments.build
    end

  end

  def evaluation
    session[:return_to] = request.referer
    @user = User.find(params[:id])

    3.times do
      evaluationteacher = @user.evaluationteachers.build
    end
  end

  def edit
  end

  def editbyadmin
    session[:return_to] = request.referer
    @user = User.find(params[:id])
    5.times do
      teacherdocument = @user.teacherdocuments.build
    end
  end

 ###

  def create

  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to session.delete(:return_to), notice: 'The user was successfully updated.' }
        format.json { respond_with_bip(@user) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json {respond_with_bip(@user)}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'The User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # select menu


################################

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
      :name, :email, :signin_id,
			:created_at,:updated_at,
      :check_teacher,:check_member,:check_staff,
			:name_chinese,:firstname,:lastname,:middlename,
			:phone_mobile,:phone_home,:phone_work,:address_street,:address_city,:address_state,:address_zipcode,
			:pic1,:pic2,:pic3,
			:contact1_name,:contact1_phone,:contact1_relationship,
      :contact2_name,:contact2_phone,:contact2_relationship,
      :position,:note,:encrypted_password,:role_id,:role_ids,
      evaluationteachers_attributes: [:id, :classlist_id, :user_id, :grade, :note,:rate ],
      teacherdocuments_attributes: [:id, :user_id, :title, :file,:note ]

       )
    end


    # sort
    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : "asc"
    end




end
