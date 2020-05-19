class Post < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 30 }

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  # カラムについての検索条件を固定
  def self.ransakable_attributes(auth_object = nil)
    %w[title created_at]
  end

  # 検索条件に意図しない関連を含めないようにする
  def self.ransakable_associations(auth_object = nil)
    []
  end

  # CSVデータに、どの属性をどの順番で出力するかを、csv_attributesクラスメソッドから取得できるように定義
  def self.csv_attributes
    ["title", "description", "content", "created_at", "updated_at"]
  end

  def self.generate_csv
    # CSV.generateを使って、CSVデータの文字列を生成。
    CSV.generate(headers: true) do |csv|
      # ヘッダを出力。csv_attributesの属性名をそのまま出力。
      csv << csv_attributes
      # allメソッドで全投稿を取得。
      all.each do |post|
        # 一つのレコードごとに、CSVの1行を出力。csv_attributesの属性ごとに、Postオブジェクトから属性値を取得してcsvに与える。
        csv << csv_attributes.map{ |attr| post.send(attr) }
      end
    end
  end
end
