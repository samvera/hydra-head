# frozen_string_literal: true

module Hydra
  # Returns AdminSets that the current user has permission to use.
  class SearchService < Blacklight::SearchService
    def current_ability
      context[:current_ability]
    end
  end
end
