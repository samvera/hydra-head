FactoryBot.define do

  #
  # Repository Objects
  #

  factory :asset, :class => ModsAsset do |o|
  end

  factory :admin_policy, :class => Hydra::AdminPolicy do |o|
  end

  factory :default_access_asset, :parent=>:asset do |a|
    permissions_attributes { [{ name: "joe_creator", access: "edit", type: "person" }] }
  end

  factory :dept_access_asset, :parent=>:asset do |a|
    permissions_attributes { [{ name: "africana-faculty", access: "read", type: "group" }, { name: "joe_creator", access: "edit", type: "person" }] }
  end

  factory :group_edit_asset, :parent=>:asset do |a|
    permissions_attributes { [{ name:"africana-faculty", access: "edit", type: "group" }, {name: "calvin_collaborator", access: "edit", type: "person"}] }
  end

  factory :org_read_access_asset, :parent=>:asset do |a|
    permissions_attributes { [{ name: "registered", access: "read", type: "group" }, { name: "joe_creator", access: "edit", type: "person" }, { name: "calvin_collaborator", access: "edit", type: "person" }] }
  end

  factory :open_access_asset, :parent=>:asset do |a|
    permissions_attributes { [{ name: "public", access: "read", type: "group" }, { name: "joe_creator", access: "edit", type: "person" }, { name: "calvin_collaborator", access: "edit", type: "person" }] }
  end

end

