class User < ActiveRecord::Base
  #this adds methods add_role, has_role, remove_role to user model
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :group_memberships
  has_many :groups, through: :group_memberships

  has_many :attendances
  has_many :periods, through: :attendances

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
end
