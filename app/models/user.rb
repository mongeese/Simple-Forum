class User < ActiveRecord::Base
  
  attr_accessor             :password
  
  has_many                  :topics
  has_many                  :posts
  
  validates_uniqueness_of   :username, :email, :case_sensitive => false
  validates_presence_of     :username, :email
  validates_presence_of     :password, :if => "#{:password_hash.nil?}"
  validates_length_of       :username, :minimum => 4
  validates_confirmation_of :password, :if => "#{:password_hash.nil?}"
  validates_format_of       :username, :with => /^[a-z]/i, :message => 'must start with a letter.', :allow_blank => true
  
  # Setup for pagination
  cattr_reader              :per_page
  @@per_page = 30
  
  # Setup gravatars
  is_gravtastic
  
  # Ferret searching
  acts_as_ferret :fields => [ :username ]
  
  # States
  include Workflow
    
  workflow do
    state :pending do
      event :activate, :transitions_to => :active
      event :delete, :transitions_to => :inactive
    end
    state :active do
      event :suspend, :transitions_to => :suspended
      event :delete, :transitions_to => :inactive
    end
    state :suspended do
      event :activate, :transitions_to => :active
      event :delete, :transitions_to => :inactive
    end
    state :inactive do
      event :activate, :transitions_to => :active
    end
  end
  
  # Methods
  def password=(password)
    @password = password
    self.password_hash = encrypt_password( password )
  end
  
  def encrypt_password( password )
    Digest::SHA1.hexdigest( password )
  end

  def self.authenticate( username, password )    
    user = User.find_by_username( username )
    return unless user
  
    if user.password_hash == user.encrypt_password( password )
      raise "You should have recieved an email to validate your account. To resend this email, click here." if user.pending?
      raise "Your account is currently suspended. Please contact an administrator." if user.suspended?
      raise "Your account has been deleted." if user.inactive?
      user
    end
  end
  
  def to_param
    username
  end
  
end
