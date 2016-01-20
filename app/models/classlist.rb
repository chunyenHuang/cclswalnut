class Classlist < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  belongs_to :user, foreign_key: :teacher_id
  has_many :students, :through => :classinfos
  has_many :classinfos
  has_many :classdocuments
  resourcify

  validates_presence_of :year
  validates_presence_of :class_name
  validates_presence_of :teacher_id
  accepts_nested_attributes_for :classdocuments, :reject_if => lambda { |a| a[:document].blank?}, :allow_destroy => true


  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    Classlist.next(self.id).first
  end

  def previous
    Classlist.previous(self.id).first
  end

  def classfullname
	"#{year} #{class_name} #{self.user.name}" 
  end

  def studentcount
    Classinfo.where(:classlist_id => self.id).count
  end


  def self.search(search)
    s="%#{search}%"
        if search
          where(
                  '
                  year LIKE ? or 
                  class_name LIKE? or 
                  kind LIKE?                 

                  ',s,s,s
                    )

        else
          all
        end
  end
end
