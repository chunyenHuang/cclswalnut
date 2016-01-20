class Classdocument < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  belongs_to :user, foreign_key: :teacher_id
  belongs_to :classlist, foreign_key: :classlist_id

  resourcify

  mount_uploader :document, PictureUploader
end
