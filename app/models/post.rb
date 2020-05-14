class Post < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 30 }

  belongs_to :user
end
