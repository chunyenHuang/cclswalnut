class Classinfo < ActiveRecord::Base
  resourcify
  belongs_to :student, foreign_key: :student_id
  belongs_to :classlist, foreign_key: :classlist_id
  scope :findtranscript, where(:id => :classinfo_id)
  

  def fullname
	"#{self.classlist.year} #{self.classlist.class_name} #{self.classlist.user.name}"
  end

  def tuitioncount
  	Classlist.where(:id => self.classlist_id).sum(:tuition)
  end
                          

end
