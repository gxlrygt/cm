ActiveAdmin.register BrokerApprovalForm, as: "GetApprovedForm" do
  actions :all, :except => [:create, :edit, :update, :destroy]
  
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

  filter :company

  show do |form|
    attributes_table do
      row :date do
        form.pretty_date
      end
      row :company
      row :company_type
      row :dba
      row :company_president
      row :broker_of_record
      row :nmls
      row :address
      row :city
      row :state do
        form.state.name
      end
      row :zip
      row :primary_contact
      row :title
      row :phone
      row :how_did_you_find_us
      row :how_did_you_find_us_account_executive_name
      row :how_did_you_find_us_other
      row :lender_paid_compensation_percentage
      row :maximum_compensation
    end
  end

  index do
    column :date do |form|
      form.pretty_date
    end
    column :company
    actions
  end
end