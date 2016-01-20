class Payment < ActiveRecord::Base
  mount_uploader :picture1, PictureUploader
  mount_uploader :picture2, PictureUploader
  mount_uploader :picture3, PictureUploader
  mount_uploader :picture4, PictureUploader
  resourcify
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  belongs_to :user
  belongs_to :member, foreign_key: :member_id


    def tuitioncount
      sum=0
      Student.where(:member_id =>self.id).each do |s|
        sum += Classlist.where(:id => Classinfo.where(:student_id =>s.id).pluck(:classlist_id)).sum(:tuition)
      end
      sum.to_f
    end

    def lastbalance
    end
  
end
