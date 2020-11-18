FactoryBot.define do

  # Users
  # Prototype user factory
  factory :user, :aliases => [:owner] do |u|
    sequence :uid do |n|
      "person#{n}"
    end
    password { uid }
  end

  factory :archivist, :parent=>:user do |u|
    uid { 'archivist1' }
    password { 'archivist1' }
  end
  factory :registered_user, :parent=>:user do |u|
    uid { 'registered_user' }
    password { 'registered_user' }
  end
  factory :staff, :parent=>:user do |u|
    uid { 'staff1' }
    password { 'staff1' }
  end
  factory :student, :parent=>:user do |u|
    uid { 'student1' }
    password { 'student1' }
  end
  factory :joe_creator, :parent=>:user do |u|
    uid { 'joe_creator' }
    password { 'joe_creator' }
  end
  factory :martia_morocco, :parent=>:user do |u|
    uid { 'martia_morocco' }
    password { 'martia_morocco' }
  end
  factory :ira_instructor, :parent=>:user do |u|
    uid { 'ira_instructor' }
    password { 'ira_instructor' }
  end
  factory :calvin_collaborator, :parent=>:user do |u|
    uid { 'calvin_collaborator' }
    password { 'calvin_collaborator' }
  end
  factory :sara_student, :parent=>:user do |u|
    uid { 'sara_student' }
    password { 'sara_student' }
  end
  factory :louis_librarian, :parent=>:user do |u|
    uid { 'louis_librarian' }
    password { 'louis_librarian' }
  end
  factory :carol_curator, :parent=>:user do |u|
    uid { 'carol_curator' }
    password { 'carol_curator' }
  end
  factory :alice_admin, :parent=>:user do |u|
    uid { 'alice_admin' }
    password { 'alice_admin' }
  end
end

