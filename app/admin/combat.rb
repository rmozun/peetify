ActiveAdmin.register Combat do
  permit_params :fighter1, :fighter2, :date, :winner, :fighter1_id, :fighter2_id, :winner_id

  index do
    selectable_column
    id_column
    column :fighter1
    column :fighter2
    column :date
    column :winner
    actions
  end

  filter :fighter1
  filter :fighter2
  filter :date
  filter :winner

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Admin Details" do
      f.input :fighter1
      f.input :fighter2
      f.input :date, :as => :datepicker
      f.input :winner
    end
    f.actions
  end

end

