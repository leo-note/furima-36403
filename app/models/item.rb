class Item < ApplicationRecord
  # 入力必須チェック
  with_options presence: true do
    validates :name
    validates :text
    validates :image
    validates :category_id
    validates :status_id
    validates :postage_defrayer_id
    validates :prefecture_id
    validates :day_to_ship_id
    validates :price
  end
  # activehash 半角数字以外・「---」の時は保存できない
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :postage_defrayer_id
    validates :prefecture_id
    validates :day_to_ship_id
  end
  # price 半角数字・入力可能範囲のチェック
  with_options numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 } do
    validates :price
  end

  # アソシエーション
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage_defrayer
  belongs_to :prefecture
  belongs_to :day_to_ship
end
