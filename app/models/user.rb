class User < ActiveRecord::Base
  rolify

  mount_uploader :pic1, PictureUploader
  mount_uploader :pic2, PictureUploader
  mount_uploader :pic3, PictureUploader

  mount_uploader :document1, PictureUploader
  mount_uploader :document2, PictureUploader
  mount_uploader :document3, PictureUploader


  has_many :students
  has_many :members
  has_many :textbooks
  has_many :classlists

  has_many :evaluationteachers
  accepts_nested_attributes_for :evaluationteachers, :reject_if => lambda { |a| a[:grade].blank?}, :allow_destroy => true

  has_many :teacherdocuments
  accepts_nested_attributes_for :teacherdocuments, :reject_if => lambda { |a| a[:file].blank?}, :allow_destroy => true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    User.next(self.id).first
  end

  def previous
    User.previous(self.id).first
  end

  def identity
    if self.check_teacher == true && self.check_staff == true
      "Staff/Teacher"
  	elsif self.check_member == true
  		"Member"
  	elsif self.check_teacher == true && self.check_staff == false
  		"Teacher"
  	elsif self.check_staff == true && self.check_teacher == false
  		"Staff"
  	else
  		"N/A"
  	end
  end

  def self.search(search)
    s="%#{search}%"
        if search
          where(
                  '
                  name LIKE ? or 
                  email LIKE? or 
                  check_teacher LIKE? or 
                  check_staff LIKE? or
                  check_member LIKE ? or

                  position LIKE ? or
                  firstname LIKE ? or
                  lastname LIKE ? or
                  middlename LIKE ? or
                  note LIKE ?                  

                  ',s,s,s,s,s,
                    s,s,s,s,s
                    )

        else
          all
        end
  end

  #after_create :default_role

  #private
  #def default_role
  #  self.roles << Role.where(:name => 'viewer').first
  #end

  after_create :set_admin

  private
  def set_admin
   if  User.count == 1
    self.roles << Role.where(:name => 'admin').first
   else
    self.roles << Role.where(:name => 'viewer').first
   end
  end

end
