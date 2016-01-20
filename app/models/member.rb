class Member < ActiveRecord::Base
  mount_uploader :father_picture, PictureUploader
  mount_uploader :mother_picture, PictureUploader
	resourcify
	belongs_to :owner, class_name: "User", foreign_key: :user_id
	belongs_to :user
  has_many :students
  has_many :payments
  has_many :classinos, through: :students
  accepts_nested_attributes_for :students, :reject_if => lambda { |a| a[:firstname].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :payments, :reject_if => lambda { |a| a[:amount].blank?}, :allow_destroy => true

  validates_presence_of :father_firstname, :mother_firstname, :mother_phone1, :father_phone1, :mother_email1, :father_email1


  	scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
    scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

    def next
      Member.next(self.id).first
    end

    def previous
      Member.previous(self.id).first
    end
    
    def parent
      "#{father_firstname} #{father_lastname}, #{father_phone1} | #{mother_firstname} #{mother_lastname}, #{mother_phone1}"
    end

    def parent_name
      "#{mother_lastname}, #{mother_firstname}  | #{father_lastname}, #{father_firstname} "
    end

    def mother_fullname
      "#{mother_name_chinese + "(" + mother_firstname + " " + mother_lastname + ")"}"
    end

    def father_fullname
      "#{father_name_chinese + "(" + father_firstname + " " + father_lastname + ")"}"
    end

    def tuitioncount_test
      Classlist.where(:id => 
                      Classinfo.where(:student_id => 
                                      Student.where(:member_id =>self.id)).pluck(:classlist_id)).sum(:tuition)
    end
    

    def studentcount
      Student.where(:member_id => self.id).count
    end

    def tuitioncount
      sum=0
      Student.where(:member_id =>self.id).each do |s|
        sum += Classlist.where(:id => Classinfo.where(:student_id =>s.id).pluck(:classlist_id)).sum(:tuition)
      end
      sum.to_f
    end

    def paid
      Payment.where(:member_id=>self.id).sum(:amount)
    end

    def balance
      tuitioncount.to_f - paid.to_f
    end

    def lastbalance
      tuitioncount.to_f - Payment.where(:member_id=>self.id).sum(:amount).to_f
    end

    def self.search(search)
		s="%#{search}%"
    t=Student.where(
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
                   ).pluck(:member_id)
	  if search
	    @member=Member.where(
         '
	    	  father_name_chinese LIKE ? or father_firstname LIKE ? or father_lastname LIKE ? or father_middlename LIKE ? or 
	    	  mother_name_chinese LIKE ? or mother_firstname LIKE ? or mother_lastname LIKE ? or mother_middlename LIKE ? or 
    		  father_phone1 LIKE ? or father_phone2 LIKE ? or father_phone3 LIKE ? or 
    		  mother_phone1 LIKE ? or mother_phone2 LIKE ? or mother_phone3 LIKE ? or 
    	      address1_street LIKE ? or address1_city LIKE ? or address1_state LIKE ? or address1_zipcode LIKE ? or 
    	      address2_street LIKE ? or address2_city LIKE ? or address2_state LIKE ? or address2_zipcode LIKE ? or 
    	      father_email LIKE ? or mother_email LIKE ? or 
          ',s,s,s,s,s, s,s,s,s,s,
            s,s,s,s,s, s,s,s,s,s,
            s,s,s,s,
          )
	  else
	    all
	  end
	end

end
