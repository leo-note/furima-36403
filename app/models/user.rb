class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 入力必須チェック
  with_options presence: true do
    validates :nickname
    validates :first_name
    validates :last_name
    validates :first_name_kana
    validates :last_name_kana
    validates :birth_date
  end
  # 全角入力のチェック
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :first_name
    validates :last_name
  end
  # 全角カタカナ入力のチェック
  with_options format: { with: /\A[ァ-ヶー]+\z/ } do
    validates :first_name_kana
    validates :last_name_kana
  end
  # パスワード半角英字・半角数字混合入力のチェック
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX
end
