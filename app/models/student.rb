class Student < ActiveRecord::Base
	mount_uploader :picture1, PictureUploader
	mount_uploader :picture2, PictureUploader
	resourcify
  belongs_to :owner, class_name: "User", foreign_key: :user_id
	belongs_to :user, foreign_key: :teacher_id
 	belongs_to :member,	foreign_key: :member_id
  
  
  has_many :classlists, :through => :classinfos
  
  has_many :classinfos, :dependent => :destroy
  has_many :transcript_classinfos, :class_name=>"Classinfo"

  accepts_nested_attributes_for :classinfos, :reject_if => lambda { |a| a[:classlist_id].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :transcript_classinfos, :allow_destroy => true

	attr_writer :current_step
	validates_presence_of :firstname, :if => lambda { |o| o.current_step == "student" }
  validates_presence_of :firstname


	scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    Student.next(self.id).first
  end

  def previous
    Student.previous(self.id).first
  end

  def tuitioncount_single
      Classlist.where(:id => 
                      Classinfo.where(:student_id =>self.id).pluck(:classlist_id)).sum(:tuition)
  end

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[member student]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
   end
  end

	def self.search(search)
		s="%#{search}%"
    	  if search
    	    where(
                  '
                  user_name LIKE ? or
                  name_chinese LIKE ? or
                  firstname LIKE ? or
                  middlename LIKE ? or
                  lastname LIKE ? or

                  nickname LIKE ? or
                  phone1 LIKE ? or
                  phone2 LIKE ? or
                  phone3 LIKE ? or
                  email1 LIKE ? or
                  
                  email2 LIKE ? or
                  school_elementary LIKE ? or
                  school_junior LIKE ? or
                  school_high LIKE ? or
                  address LIKE ? or
                  
                  birthday LIKE ? or
                  note LIKE ? 
                  
                  ',s,s,s,s,s, s,s,s,s,s,
                    s,s,s,s,s, s,s
                   )

    	  else
    	    all
    	  end
  end





end
