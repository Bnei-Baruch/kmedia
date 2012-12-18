class VirtualLesson < ActiveRecord::Base
  has_many :lessons
end