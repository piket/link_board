class User < ActiveRecord::Base

    has_secure_password

    has_many :posts
    has_many :votes, as: :votable
    has_many :ratings, class_name: 'Vote'
    has_many :comments

    validates :name,
        presence: true,
        length: {maximum: 20}

    validates :password,
        presence: true,
        on: :create

    validates :email,
        presence: true,
        email_format: {},
        uniqueness: true

    def self.authenticate name, password
        User.find_by_name(name).try(:authenticate, password)
    end

end
