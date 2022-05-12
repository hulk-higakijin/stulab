ActiveAdmin.register User do
  active_admin_paranoia
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :introduction, :twitter_url, :youtube_url, :public_uid, :admin, :author, :deleted_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :introduction, :twitter_url, :youtube_url, :public_uid, :admin, :author, :deleted_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :email, :name, :introduction, :created_at, :updated_at
end
