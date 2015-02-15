class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :state
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  has_many :assets
  has_many :comments
  has_and_belongs_to_many :tags
  attr_accessor :tag_names
  accepts_nested_attributes_for :assets
  #mount_uploader :asset, AssetUploader

  before_create :associate_tags

  private

  def associate_tags
    if tag_names
      tag_names.split(" ").each do |name|        
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end

  def self.search(query)
    query      
      .split(" ") # turns string into array
      .collect do |query| # transformates the array
        query.split(":") 
      end.inject(self) do |klass, (name, q)| # takes the array of things and boils it down to one
        association = klass.reflect_on_association(name.to_sym)
        unless association
          name = name.pluralize
          association = klass.reflect_on_association(name.to_sym)
        end
        
        association_table = association.klass.arel_table
        
        if [:has_and_belongs_to_many,
            :belongs_to].include?(association.macro)
          joins(name.to_sym)
            .where(association_table["name"].eq(q))
        else
          all
        end
      end
  end
end
