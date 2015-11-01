ActiveAdmin.register ContactForm do
  actions :index, :show
  
  index do
    column :name
    column :email
    column :company
    column :message
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :company
      row :message
    end
  end

end