class Homework < ActiveRecord::Base
  belongs_to :period
  belongs_to :user

  has_attached_file :hw_archive
  validates_attachment_content_type :hw_archive,
                                    content_type: ['application/x-rar-compressed', 'application/zip'],
                                    message: 'Only rar/zip format!'

  validates :hw_archive, presence: true, :allow_nil => false

  if User.current_user.has_any_role? :student
    before_save do #rename archive
      name = User.current_user.name
      surname = User.current_user.surname
      group_name = self.period.group.name.split.join('-')
      hw = self.period.title.split.join('-')
      params_array = [name, surname, group_name, hw]
      self.hw_archive_file_name = "#{params_array.join('-').downcase! + '.zip'}"
    end
  end

end
