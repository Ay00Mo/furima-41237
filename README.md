# README

## usersテーブル
| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| nickname           | string     | null: false               |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false               |
| last_name          | string     | null: false               |
| first_name         | string     | null: false               |
| kana_last_name     | string     | null: false               |
| kana_first_name    | string     | null: false               |
| birthday           | date       | null: false               |


### Association
- has_many :items
- has_many :orders


## itemsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| description        | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| shipping_fee       | integer    | null: false                    |
| shipping_from      | string     | null: false                    |
| days_to_ship       | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order


## ordersテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false. foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :mailing_address


## Mailing_addressesテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| address            | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | string     | null: false                    |
| order              | references | null: false, foreign_key: true |

### Association
- belongs_to :order