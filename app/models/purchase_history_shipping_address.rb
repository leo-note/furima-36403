class PurchaseHistoryShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token,
                :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number

  # 入力必須チェック
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :phone_number
  end
  # postal_code 「xxx-xxxx」の半角文字列以外は保存できない
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  # activehash 半角数字以外・「---」の時は保存できない
  validates :prefecture_id, numericality: { other_than: 1 }
  # phone_number 10桁以上11桁以内の半角数値以外は登録できない
  validates :phone_number, length: { in: 10..11 }, numericality: true

  def save
    purchase_history = PurchaseHistory.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                           house_number: house_number, building_name: building_name, phone_number: phone_number,
                           purchase_history_id: purchase_history.id)
  end
end
