module Hydra
  class SearchBuilder < Blacklight::SearchBuilder
    # Add a filter query to restrict the search to documents the current user has access to
    include Hydra::AccessControlsEnforcement
  end
end
