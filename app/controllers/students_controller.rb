class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
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
    @students = Student.order(sort_column + " " + sort_direction)
                       .paginate(page: params[:page], per_page: 10)
                       .search(params[:search])
  end

  def show
    session[:return_to] = request.referer  
    @students = Student.find(params[:id],params[:user_id],params[:member_id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
      #format.pdf { render :layout => false }
      format.pdf do
        pdf = Prawn::Document.new
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
  end

  ###

  def duplicate
    session[:return_to] = request.referer  
    @student = Student.find(params[:id],params[:user_id],params[:member_id],params[:teacher_id]).dup
    @student.current_step = session[:member_step]
  end

  def new
    session[:return_to] = request.referer  
    @student = Student.new(session[:student_params])
    @classlist = Classlist.order(year: :desc)
    @T=nil

    @student.current_step = session[:student_step]

    1.times do
      classinfo = @student.classinfos.build
    end
  end

  def edit
    session[:return_to] = request.referer   

    @student = Student.find(params[:id],params[:user_id],params[:member_id],params[:class_id])
    @classlist = Classlist.order(year: :desc)
    @member_select=Member.order(mother_lastname: :asc)
    @M=@student.member.id
    @T=@student.classinfos do |classinfo| 
        classinfo.class_id
      end

    classinfo = @student.classinfos.build

  end

  def edit_transcript
    session[:return_to] = request.referer   

    @student = Student.find(params[:id])
    @find_classinfo = Classinfo.find(params[:classinfo_id])

  end


############


  def create
    session[:student_params].deep_merge!(params[:student]) if params[:student]
    @student = current_user.students.new(session[:student_params])
    @student.current_step = session[:student_step]
    
    if @student.valid?
        if params[:back_button]
          @student.previous_step
        elsif @student.last_step?
          @student.save if @student.all_valid?
        else 
          @student.next_step 
        end
          session[:student_step] = @student.current_step
    end
    
    if @student.new_record?
      render "new"
    else
      session[:student_step] = session[:student_params] = nil
      redirect_to students_path
    end
  end

  def update
    @student = Student.find(params[:id],params[:user_id],params[:member_id],params[:teacher_id])

    #redirect_to session.delete(:return_to)

    respond_to do |format|
      if @student.update_attributes(student_params)
        format.html { redirect_to session.delete(:return_to), notice: 'The student was successfully updated.' }
        format.json { respond_with_bip(@student) }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json {respond_with_bip(@student)}
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orderlists/1
  # DELETE /orderlists/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_path, notice: 'The student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # select menu

  
################################

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(
        :user_id,:user_name,:teacher_id,:member_id,:created_at,:updated_at,:name_chinese,:firstname,:middlename,:lastname,:nickname,
        :phone1,:phone2,:phone3,:email1,:email2,:school_elementary,:school_junior,:school_high,:address,:birthday,
        :picture1,:picture2,:note,
        classinfos_attributes: [:id, :classlist_id, :year, :class_name, :note,:check_pay,:tuition,
                                :midterm, :final, :quiz1, :quiz2, :quiz3, :quiz4, :quiz5],
        transcript_classinfos_attributes: [:id, :classlist_id, :year, :class_name, :note,:check_pay,:tuition,
                                :midterm, :final, :quiz1, :quiz2, :quiz3, :quiz4, :quiz5]
       )
    end

    def classinfo_params
      params.require(:classinfo).permit(
        :id, :classlist_id, :year, :class_name, :note,:check_pay,:tuition, :midterm, :final, :quiz1, :quiz2, :quiz3, :quiz4, :quiz5
       )
    end
    # sort
    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
    
    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end

