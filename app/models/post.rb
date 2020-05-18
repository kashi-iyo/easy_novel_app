class Post < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 30 }

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  # カラムについての検索条件を固定
  def self.ransakable_attributes(auth_object = nil)
    %w[name created_at]
  end

  # 検索条件に意図しない関連を含めないようにする
  def self.ransakable_associations(auth_object = nil)
    []
  end
end
