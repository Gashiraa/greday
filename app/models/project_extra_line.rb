class ProjectExtraLine < ApplicationRecord
  belongs_to :project
  belongs_to :extra, optional: true
end