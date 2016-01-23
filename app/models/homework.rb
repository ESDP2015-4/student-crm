class Homework < ActiveRecord::Base
  belongs_to :period

  has_attached_file :hw_archive
  validates_attachment_content_type :hw_archive,
                                    content_type: ['application/x-rar-compressed', 'application/zip']
  validates :hw_archive_file_size, presence: true, :allow_nil => false
end
