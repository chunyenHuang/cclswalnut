class ClasslistsController < ApplicationController
  before_action :set_classlist, only: [:show, :edit, :update, :destroy]
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
    @classlists = Classlist.where(:active => true)
                           .order(year: :desc,kind: :desc, class_name: :asc)
                           .paginate(page: params[:page], per_page: 25)
                           .search(params[:search])
  end

  def archive_classes
    session[:return_to] = request.referer
    @classlists = Classlist.where(:active => false)
                           .order(year: :desc,kind: :desc, class_name: :asc)
                           .paginate(page: params[:page], per_page: 25)
                           .search(params[:search])
  end


  def show
    session[:return_to] = request.referer
    @classlists = Classlist.find(params[:id],params[:user_id],params[:teacher_id])
  end

####

  def new
    session[:return_to] = request.referer
    @classlist = Classlist.new
    @teacher_select = User.where(:check_teacher => true).order(:name)
    @T=nil
    @prompt=nil
    @yearnow=Time.now.strftime("%Y")
  end

  def edit
    #session[:return_to] ||= request.referer
    session[:return_to] = request.referer
    @classlist = Classlist.find(params[:id])
    @teacher_select = User.where(:check_teacher => true).order(:name)
    @T=@classlist.user.id
    @prompt=nil
    @yearnow=@classlist.year
  end

  def uploaddocument
    session[:return_to] = request.referer
    @classlist = Classlist.find(params[:id])

    @teacher_select = User.where(:check_teacher => true).order(:name)
    @T=@classlist.user.id
    @prompt=nil
    @yearnow=@classlist.year

    12.times do
      classdocument = @classlist.classdocuments.build
    end
  end

  def duplicate
    session[:return_to] = request.referer
    @classlist = Classlist.find(params[:id]).dup
  end

###

  def create
    @classlist = current_user.classlists.new(classlist_params)

    respond_to do |format|
      if @classlist.save
        format.html { redirect_to session.delete(:return_to), notice: 'Classlist was successfully created.' }
        format.json { render :show, status: :created, location: @classlist }
      else
        format.html { render :new }
        format.json { render json: @classlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @classlist = Classlist.find(params[:id])

    respond_to do |format|
      if @classlist.update_attributes(classlist_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Classlist was successfully updated.' }
        format.json { respond_with_bip(@classlist) }
        format.json { render :show, status: :ok, location: @classlist }
      else
        format.html { render :edit }
        format.json {respond_with_bip(@classlist)}
        format.json { render json: @classlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @classlist.destroy
    respond_to do |format|
      format.html { redirect_to classlists_url, notice: 'Classlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    def set_classlist
      @classlist = Classlist.find(params[:id])
    end

  def classlist_params
    params.require(:classlist).permit(
    :created_at,:updated_at,
    :active,
    :year,:class_name,:kind,:tuition,:tuition_count, :note,:place,
    :teacher_id,:user_id,
    :date_from, :date_to, :time_from, :time_to,
    classdocuments_attributes: [:id, :created_at,:updated_at,:classlist_id,
                                :user_id,:teacher_id,:document,:note,:title]

    )
  end
      # sort
    def sort_column
      Classlist.column_names.include?(params[:sort]) ? params[:sort] : "year"
    end

    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : "desc"
    end

end
