class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]

  validates :user_id, presence: true

  validates :votable_id, presence: true

end
