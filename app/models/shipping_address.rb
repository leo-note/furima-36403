class ShippingAddress < ApplicationRecord
  belongs_to :purchase_history
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
