ActiveAdmin.register User do
  active_admin_paranoia
  permit_params :email, :name, :introduction, :created_at, :updated_at
end
