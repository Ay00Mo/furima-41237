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

  private

  def password_complexity
    return if password.blank? || password =~ /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

    errors.add :password, 'は英字と数字の両方を含めて設定してください'
  end
end
