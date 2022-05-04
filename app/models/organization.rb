class Organization < ApplicationRecord
  before_action :clean_name

  has_rich_text    :description
  has_one_attached :logo

  validates_uniqueness_of :name,   allow_blank: true, case_sensitive: false
  validates_uniqueness_of :domain, allow_blank: true, case_sensitive: false
  validates :logo, content_type: ['image/png', 'image/jpeg', 'image/jpg'], 
                    size: { between: 1.kilobyte..5.megabytes , message: 'is not given between size' }
  validates :owner_id, presence: true

  private

  def clean_name
    self.name = self.name.strip
  end

  def organization_params
    params.require(:organization).permit(:name, :description, :logo, :domain, :owner_id)
  end
end
