class Chef < ApplicationRecord
  before_save :downcase_email
  validates :chefname, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates_format_of :email, with: VALID_EMAIL_REGEX

  private

  def downcase_email
    self.email = self.email.downcase
  end
end
