# テーブル設計

## users テーブル
| Column                | Type           | Options                         |
|--------------------------------------------------------------------------|
| nickname              | string         | null:false                      |
| email                 | string         | null:false, unique:true         |
| encrypted_password    | string         | null:false                      |
| first_name            | string         | null:false                      |
| last_name             | string         | null:false                      |
| first_name_kana       | string         | null:false                      |
| last_name_kana        | string         | null:false                      |
| birth_date            | date           | null:false                      |

### association
- has_many :items
- has_many :comments
- has_many :purchase_histories

## items テーブル
| Column                | Type           | Options                         |
|--------------------------------------------------------------------------|
| name                  | string         | null:false                      |
| text                  | text           | null:false                      |
| category_id           | integer        | null:false                      |
| status_id             | integer        | null:false                      |
| postage_defrayer_id   | integer        | null:false                      |
| prefecture_id         | integer        | null:false                      |
| day_to_ship_id        | integer        | null:false                      |
| price                 | integer        | null:false                      |
| user                  | references     | null:false,foreign_key:true     |

### association
- belongs_to :user
- has_many :comments
- has_one :purchase_history

### other
- using ActiveStorage and ActiveHash(category,status,postage_defrayer,prefecture,day_to_ship)

## comments テーブル
| Column                | Type           | Options                         |
|--------------------------------------------------------------------------|
| text                  | text           | null:false                      |
| user                  | references     | null:false,foreign_key:true     |
| item                  | references     | null:false,foreign_key:true     |

### association
- belongs_to :user
- belongs_to :item

## purchase_histories テーブル
| Column                | Type           | Options                         |
|--------------------------------------------------------------------------|
| user                  | references     | null:false,foreign_key:true     |
| item                  | references     | null:false,foreign_key:true     |

### association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル
| Column                | Type           | Options                         |
|--------------------------------------------------------------------------|
| postal_code           | string         | null:false                      |
| prefecture_id         | string         | null:false                      |
| city                  | string         | null:false                      |
| house_number          | string         | null:false                      |
| building_name         | string         |                                 |
| phone_number          | string         | null:false                      |
| purchase_history      | references     | null:false,foreign_key:true     |

### association
- belongs_to :purchase_history

### other
- using ActiveHash(prefecture)
