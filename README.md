# README
# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| mail               | string | null: false |
| encrypted_password | string | null: false |

### Association

- belongs_to :personal_information
- has_many   :items

## personal_informations テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| surname        | string     | null: false                    |
| givenname      | string     | null: false                    |
| surname_kana   | string     | null: false                    |
| givenname_kana | string     | null: false                    |
| birthday       | date       | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- has_one  :user
- has_many :deliveries

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| title           | string     | null: false                    |
| describe        | text       | null: false                    |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| price           | integer    | null: false                    |
| shipping_charge | string     | null: false                    |
| from_location   | string     | null: false                    |
| shipping_date   | date       | null: false                    |
| user            | references | null: false, foreign_key: true |
| delivery        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :delivery

## deliveries テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| postcode             | integer    | null: false                    |
| prefecture           | string     | null: false                    |
| city                 | string     | null: false                    |
| addresses            | string     | null: false                    |
| building             | string     | null: false                    |
| phonenumber          | integer    | null: false                    |
| item                 | references | null: false, foreign_key: true |
| personal_information | references | null: false, foreign_key: true |

### Association

- belongs_to :personal_information
- has_one    :item
