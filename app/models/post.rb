class Post < ActiveRecord::Base
  
  has_one                       :topic
  belongs_to                    :topic
  belongs_to                    :user
  
  # Setup for pagination
  cattr_reader                  :per_page
  @@per_page = 5
  
  # Ferret searching
  acts_as_ferret :fields => [ :content ]
  
  def to_param
    post_anchor
  end
  
  def post_anchor
    self[:topic].url_title
  end
  
end
