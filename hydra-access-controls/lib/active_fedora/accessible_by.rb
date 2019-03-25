ActiveFedora::QueryMethods.module_eval do
  extend ActiveSupport::Concern

  def accessible_by(ability, action = :index)
    permission_types = case action
      when :index then [:discover, :read, :edit]
      when :show, :read then [:read, :edit]
      when :update, :edit, :create, :new, :destroy then [:edit]
    end

    builder = Hydra::SearchBuilder.new(nil, ability: ability, permission_types: permission_types)
    filters = builder.send(:gated_discovery_filters).join(" OR ")
    spawn.where!(filters)
  end
end

ActiveFedora::Querying.module_eval do
  delegate :accessible_by, :to=>:all
end
