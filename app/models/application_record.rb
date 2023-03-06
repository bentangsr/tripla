class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include ManageCache

  after_commit :delete_current_cache
end
