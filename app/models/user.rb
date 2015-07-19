class User < ActiveRecord::Base
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :remember_token
  validates :first_name,
            :presence => {:message => " cannot be blank"},
            :length => {in: 2..25, :message => 'Must be between 2 to 25 characters'}

  validates :last_name,
            :presence => {:message => " cannot be blank"},
            :length => {in: 2..25, :message => 'Must be between 2 to 25 characters'}

  validates :email,
            :presence => {:message => " cannot be blank"},
            :length => {:maximum => 100, :message => 'Must be less than 100 characters'},
            :email => true,
            :uniqueness => {:message => " already exists"}

  validates :password_digest,
            :length => {:minimum => 6, :message => "Must be atleast 6 characters"}

  has_secure_password

  def remember_me!
    self.remember_token = Digest::MD5.hexdigest("#{id}--#{Time.now.utc}")
    self.save
  end


end
