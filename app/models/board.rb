class Board < ActiveRecord::Base

  has_many                      :topics
  validates_presence_of         :name
  
  def url_title
    "#{self[:id]}-#{self[:name].downcase.gsub(/\W+/, "-")}" 
  end

  def to_param
    url_title
  end
  
  def self.find_by_url_title(url)
    Board.find(url.to_i)
  end

end
