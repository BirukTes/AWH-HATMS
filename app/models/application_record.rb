# Parent of subsequent subclasses, inherits from ActiveRecord
#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
