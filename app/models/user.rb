class User < ApplicationRecord
  has_many :news, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: { user: 0, admin: 1 }

  after_initialize :set_default_role, :if => :new_record?

  private

  def set_default_role
    self.role ||= :user
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
end
