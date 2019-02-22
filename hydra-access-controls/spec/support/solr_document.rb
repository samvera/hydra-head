# frozen_string_literal: true

class SolrDocument
  def initialize(source_doc = {}, _solr_response = nil)
    @source_doc = source_doc
  end

  def id
    fetch(:id)
  end

  def fetch(field, _default = nil)
    @source_doc[field]
  end

  def [](field)
    @source_doc[field]
  end
end
