class User < ActiveRecord::Base
  #this adds methods add_role, has_role, remove_role to user model
  rolify
  audited  on: [:update]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :group_memberships
  has_many :student_groups,     through: :group_memberships,  source: :group

  has_many :teachers_groups
  has_many :teacher_groups,     through: :teachers_groups,    source: :group

  has_many :supports_groups
  has_many :techsupport_groups, through: :supports_groups,    source: :group

  has_many :student_courses,     -> { distinct }, through: :student_groups,     source: :course
  has_many :teacher_courses,     -> { distinct }, through: :teacher_groups,     source: :course
  has_many :techsupport_courses, -> { distinct }, through: :techsupport_groups, source: :course

  has_many :attendances
  has_many :periods, through: :attendances
  #has_and_belongs_to_many :roles, join_table: :users_roles  #might not need this one, if no error, delete this line

  has_many :homeworks

  has_attached_file :image,
                    styles: {medium: '300x300>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image,
                                    content_type: ['image/jpeg', 'image/gif', 'image/png']

  def password_required?
    new_record? ? false : super
  end

  after_create { |user| user.send_reset_password_instructions }

  validates :name, presence: true, length: {maximum: 250}
  validates :surname, presence: true, length: {maximum: 250}
  validates :gender, presence: true
  validates :phone1, presence: true
  validates :email, presence: true
  validates_format_of :email, :with => /@gmail\.com\z/, message: "Допустим только gmail аккаунт"
  validates :passportdetails, presence: true

  validates :phone1, presence: true
  my_regex = /\A(\+996)([0-9]{9})\z/
  validates_format_of :phone1,
                      :with => my_regex,
                      message: "Phone must be like +996xxxYYYYYY, where xxx - your operator's code and YYYYYY - your phone number"

  validates_format_of :phone2,
                      :with => my_regex,
                      :allow_blank => true,
                      message: "Phone must be like +996xxxYYYYYY, where xxx - your operator's code and YYYYYY - your phone number"

  def full_name
    "#{name} #{surname} #{middlename}"
  end

  def self.all_students_except(student_ids)
    student_role = Role.find_by(name: :student)
    students = student_role.users
    students.where.not(id: student_ids).order(created_at: :desc)
  end

  def self.search(search, scoped_users)
    if search
      where('users.name || users.surname || users.email || users.phone1 || users.phone2 || users.skype LIKE ?', "%#{search}%")
    else
      scoped_users
    end
  end

  GENDERS = ['female', 'male']
  GENDERS_LABELS = ['Женщина', 'Мужчина']

  def self.get_genders
    genders_for_collection = []
    GENDERS.each_with_index do |item, index|
      genders_for_collection.push([item, GENDERS_LABELS[index]])
    end
    genders_for_collection
  end

  def gender_string
    GENDERS_LABELS[GENDERS.index(gender)]
  end

  class << self #this is for ability to use "current_user" method in model
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end

end
