ActiveAdmin.register Book do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :introduction, :price, :likes_count, :deleted_at, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :introduction, :price, :likes_count, :deleted_at, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :status

  form do |f|
    f.inputs 'Book' do
      f.input :title
      f.input :status, as: :select, collection: Book.statuses.keys
    end
    f.actions
  end
end
