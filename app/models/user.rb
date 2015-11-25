class User < ActiveRecord::Base
  #След вызов добавит методы add_role, has_role, remove_role к модели user
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
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image,
                    content_type: ['image/jpeg', 'image/gif', 'image/png']

  def password_required?
    new_record? ? false : super
  end

  validates :name, presence: true, length: {maximum: 250}
  validates :surname, presence: true, length: {maximum: 250}
  validates :gender, presence: true
  validates :phone1, presence: true

  validates :passportdetails, presence: true
end
