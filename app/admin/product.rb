ActiveAdmin.register Product do
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  filter :name

  permit_params :name, :category, :subcategory, :table_html, :description, :iframe_url

  controller do

    def create
      if params[:product][:table_html]
        params[:product][:table_html] = ProductService::HtmlFileParser.new(params[:product][:table_html].tempfile).perform
      end
      super
    end

    def update
      if params[:product][:table_html]
        params[:product][:table_html] = ProductService::HtmlFileParser.new(params[:product][:table_html].tempfile).perform
      end
      super
    end
  end

  form html: { enctype: "multipart/form-data" } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :name, as: :string, hint: "DO NOT CHANGE THIS NAME UNLESS YOU KNOW WHAT YOU ARE DOING"
      f.input :table_html, as: :file, hint: "Upload the HTML file that you exported from Excel"
      f.input :iframe_url, hint: "Iframe code for Google spreadsheet"
    end
    f.actions
  end

  show do |product|
    attributes_table do
      row :name
      row :iframe_url
    end
  end

  index do
    column :name
    actions
  end
end