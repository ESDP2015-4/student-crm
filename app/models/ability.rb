class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    if user.is_admin?
      #Может управлять всем
      can :manage, :all

    elsif user.is_manager?
      #Может управлять всем, пока что
      can :manage, Course
      can :manage, CourseElement
      can :manage, Period
      can :manage, Group
      can :manage, GroupMembership
      can :manage, Course
      can :manage, User
      can :manage, StudyUnit

    elsif user.is_teacher?
      #Может просматривать профили всех пользователей
      can :read, User
      #Может управлять своим профилем
      can [:show, :update], User, :id => user.id
      # Может управлять занятиями --- необходимо добавить только свои занятия!!!!!!!!!!!
      can :manage, Period

      can :manage, Course, :id => user.teacher_courses.ids

      # Может управлять раздатками только своих курсов
      can [:manage], CourseElement, :id => CourseElement.where(course_id: user.teacher_courses.ids).ids

      can [:create], CourseElement

      can [:read, :change_tab], Group

      can :manage, Attendance

      can :manage, Homework

    elsif user.is_techsupport?
      #Может просматривать профили всех пользователей
      can :read, User
      #Может управлять своим профилем
      can [:show, :update], User, :id => user.id

      can :manage, Homework

    elsif user.is_student?
      #Может управлять своим профилем
      can [:show, :update ], User, :id => user.id
      can :manage, Homework

      # Может просматривать только свои курсы
      can [:read, :classmates], Course, :id => user.student_courses.ids

      # Может просматривать раздатки только своих курсов
      can [:read], CourseElement, :id => CourseElement.where(course_id: user.student_courses.ids).ids

      can [:read], Period

      can [:create, :update, :show, :index, :replace], Homework, :id => user.id
    else

    end


    # Left the comments to surve as a mini documentation
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
