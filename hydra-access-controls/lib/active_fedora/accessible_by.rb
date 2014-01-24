ActiveFedora::Relation.class_eval do
  include Hydra::AccessControlsEnforcement
  def accessible_by(ability, action = :index)
    return self if ability.blank?

    permission_types = case action
      when :index then [:discover, :read, :edit]
      when :show, :read then [:read, :edit]
      when :update, :edit, :create, :new, :destroy then [:edit]
    end

    relation = clone
    relation.where_values = gated_discovery_filters(ability, permission_types).join(' OR ')
    relation
  end
end

ActiveFedora::Querying.module_eval do
  delegate :accessible_by, :to=>:all
end
