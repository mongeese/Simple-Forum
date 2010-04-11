class Topic < ActiveRecord::Base
  
  belongs_to                    :user
  
  belongs_to                    :board
  accepts_nested_attributes_for :board
  
  belongs_to                    :first_post, :class_name => 'Post'
  accepts_nested_attributes_for :first_post
  has_many                      :posts
  
  validates_presence_of         :title, :user_id, :views, :first_post
  validates_format_of           :title, :with => /^[a-z]/i, :message => 'must start with a letter.', :allow_blank => true
  
  # Setup for pagination
  cattr_reader              :per_page
  @@per_page = 20
  
  # Ferret searching
  acts_as_ferret
  
  def url_title
    "#{self[:id]}-#{self[:title].downcase.gsub(/\W+/, "-")}" 
  end

  def to_param
    url_title
  end
  
  def self.find_by_url_title(url)
    Topic.find(url.to_i)
  end
  
end
