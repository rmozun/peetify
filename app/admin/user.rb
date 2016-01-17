ActiveAdmin.register User do
  permit_params :email, :name

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :email
    end
    f.actions
  end

end
