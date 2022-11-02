class Recipe < ApplicationRecord
  validates :name, :description, presence: true
  has_rich_text :description

  belongs_to :chef
end
