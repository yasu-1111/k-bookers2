class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def User.search(search, user_or_book, how_search)
      if user_or_book == "1"
          if how_search == "1"
                  User.where(['name LIKE ?', "%#{search}%"])
          elsif how_search == "2"
                  User.where(['name LIKE ?', "%#{search}"])
          elsif how_search == "3"
                  User.where(['name LIKE ?', "#{search}%"])
          elsif how_search == "4"
                  User.where(['name LIKE ?', "#{search}"])
          else
                  User.all
          end
      end
  end

end
