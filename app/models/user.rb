class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true
  validates :kana_first_name, presence: true
  validates :birthday, presence: true
  validate :password_complexity
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' }
  validates :kana_last_name, :kana_first_name,
            format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters.' }

  private

  def password_complexity
    return if password.blank?

    if password =~ /\A[a-zA-Z]+\z/ # rubocop:disable Style/IfUnlessModifier
      errors.add(:password, 'cannot be only letters')
    end

    if password =~ /\A\d+\z/ # rubocop:disable Style/IfUnlessModifier
      errors.add(:password, 'cannot be only numbers')
    end

    return unless password =~ /[^\x00-\x7F]/

    errors.add(:password, 'cannot include full-width characters')
  end
end
