class Teacherdocument < ActiveRecord::Base
	  mount_uploader :file, PictureUploader

	belongs_to :user, foreign_key: :user_id

end
