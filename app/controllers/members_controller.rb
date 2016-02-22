class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  authorize_resource
  respond_to :html, :json


  def previous
    self.class.first(:conditions => ["id < ?", :id], :order => "id desc")
  end

  def next
    self.class.first(:conditions => ["id > ?", :id], :order => "id asc")
  end

###

  def index
    session[:return_to] = request.referer
    @members = Member.all
  end

  def show
    @count = 1
    session[:return_to] = request.referer
    @members = Member.find(params[:id],params[:user_id],params[:teacher_id])
  end

  def show_payments
    session[:return_to] = request.referer
    @member = Member.find(params[:id],params[:user_id],params[:teacher_id])
  end

###



  def new
    session[:return_to] = request.referer
    @member = Member.new
  end

  def new_family
    session[:return_to] = request.referer
    @member = Member.new
    @classlist = Classlist.order(year: :desc)
    @T=nil

    3.times do
      student = @member.students.build
      3.times { student.classinfos.build }
    end
  end

  def payment
    session[:return_to] = request.referer

    @member = Member.find(params[:id])
    3.times do
      payment = @member.payments.build
    end
  end

  def edit
    session[:return_to] = request.referer

    @member = Member.find(params[:id])
    @student = Student.find(params[:id],params[:user_id],params[:member_id],params[:class_id])
    @classlist = Classlist.order(year: :desc)
    @member_select=Member.order(mother_lastname: :asc)
    @T=@student.classinfos do |classinfo|
        classinfo.class_id
      end

    2.times do
      student = @member.students.build
      3.times { student.classinfos.build }
    end
  end


##############

  def create
    @member = current_user.members.new(member_params)
    if current_user.has_role? :viewer
      respond_to do |format|
        if @member.save
          format.html { redirect_to classlists_thankyou_url, notice: 'Thank you!' }
          format.json { render :show, status: :created, location: @member }
        else
          format.html { render :new_family }
          format.json { render json: @member.errors, status: :unprocessable_entity }
          3.times do
          student = @member.students.build
          3.times { student.classinfos.build }
        end
        end
      end
    else
      respond_to do |format|
        if @member.save
          format.html { redirect_to session.delete(:return_to), notice: 'Member was successfully created.' }
          format.json { render :show, status: :created, location: @member }
        else
          format.html { render :new_family }
          format.json { render json: @member.errors, status: :unprocessable_entity }
          3.times do
          student = @member.students.build
          3.times { student.classinfos.build }
        end
        end
      end
    end
  end

  def update
    @member = Member.find params[:id]
    respond_to do |format|
      if @member.update_attributes(member_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Member was successfully updated.' }
        format.json { respond_with_bip(@member) }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json {respond_with_bip(@member)}
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    def set_member
      @member = Member.find(params[:id])
    end

  def member_params
    params.require(:member).permit(
    	:created_at,:updated_at,
    	:father_name_chinese,:father_firstname,:father_lastname,:father_middlename,
    	:mother_name_chinese,:mother_firstname,:mother_lastname,:mother_middlename,
    	:father_phone1,:father_phone2,:father_phone3,
    	:mother_phone1,:mother_phone2,:mother_phone3,
    	:address1_street,:address1_city,:address1_state,:address1_zipcode,
    	:address2_street,:address2_city,:address2_state,:address2_zipcode,
    	:father_email1,:father_email2,:mother_email1,:mother_email2,
      :father_picture,:mother_picture,
      :check_address_same,
      students_attributes: [:id, :user_id,:user_name,:teacher_id,:member_id,:created_at,:updated_at,:name_chinese,
                            :firstname,:middlename,:lastname,:nickname, :phone1,:phone2,:phone3,:email1,:email2,
                            :school_elementary,:school_junior,:school_high,:address,:birthday,:picture1,:picture2,:note,
                            classinfos_attributes: [:id, :classlist_id, :year, :class_name, :teacher_id,:transcript,
                                                    :note,:check_pay,:tuition]
                            ],
      payments_attributes: [:id, :created_at,:updated_at, :user_id, :member_id,
                            :amount, :checknumber, :cash, :note,
                            :picture1, :picture2, :picture3, :picture4
      ]

    )
  end


      # sort
    def sort_column
      Member.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
