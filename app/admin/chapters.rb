ActiveAdmin.register Chapter do
  active_admin_paranoia
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :number, :caption, :book_id, :deleted_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:number, :caption, :book_id, :deleted_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
