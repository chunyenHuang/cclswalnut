class Ability
  include CanCan::Ability

  def initialize(user)
    #user ||= User.new
    #admin=1
    if user.has_role? :admin #1
      can :manage, :all

    #manager=2
    elsif user.has_role? :manager #2
      can :manage, :all
      cannot :destroy, :all

    #teacher=3
    elsif user.has_role? :teacher #3
      can :index, Classlist
      can :read, Classlist, :teacher_id => user.id
      can :show, User, :id => user.id
      can :edit_transcript, Student, :id => Classinfo.where(:classlist_id => Classlist.where(:teacher_id => user.id).pluck(:id)).pluck(:student_id)
      can :update, Student, :id => Classinfo.where(:classlist_id => Classlist.where(:active=>true).where(:teacher_id => user.id).pluck(:id)).pluck(:student_id)
      can :edit_transcript,:all
      can :uploaddocument, :all
      can :update, Classlist, :id => Classlist.where(:active=>true).where(:teacher_id => user.id).pluck(:id)
      #can :read, Classlist, :teacher_id => User.with_role(:teacher, user).pluck(:id)
    
    #member=4
    elsif user.has_role? :member #4
      can :index, Classlist 

    #user=5  user.has_role? :viewer #5
    elsif user.has_role? :viewer
      can :welcome, :all 
      can :thankyou, :all
      can :new_family, :all
      can :create, Member
      can :create, Student
    else   
      can :welcome, :all 
      can :new_family, :all
      can :update, Member
      can :create, Student
      #can :manage, :all
      #can :search, :all if user.has_role? :manager
      #can :duplicate, :all if user.has_role? :manager

      #can :read, Orderlist if user.has_role? :manager
      #can :new, Orderlist if user.has_role? :manager
      #can :create, Orderlist if user.has_role? :manager
      #can :edit, Orderlist if user.has_role? :manager
      #can :update, Orderlist if user.has_role? :manager
      #can :edit, Orderlist, :id => Orderlist.with_role(:moderator, user).pluck(:id)
      #can :update, Orderlist, :id => Orderlist.with_role(:moderator, user).pluck(:id)
    end

  end

 # protected

  
  #def basic_read_only
  # can :read
  #end
end