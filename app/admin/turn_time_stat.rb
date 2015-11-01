ActiveAdmin.register TurnTimeStat do
  actions :index, :show, :update, :edit
  menu parent: 'Settings'

  config.filters = false

  permit_params :drawing_docs, :underwriting, :conditions, :funding

  index do
    column :drawing_docs
    column :underwriting
    column :conditions
    column :funding
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :drawing_docs, as: :string
      f.input :underwriting, as: :string
      f.input :conditions, as: :string
      f.input :funding, as: :string
    end
    f.actions
  end

  show do
    attributes_table do
      row :drawing_docs
      row :underwriting
      row :conditions
      row :funding
    end
  end

end