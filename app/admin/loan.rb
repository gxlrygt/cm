ActiveAdmin.register Loan do
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

  show do |form|
    attributes_table do
      row :date do
        form.pretty_date
      end
      row :account_executive
      row :lender_or_borrower_paid
      row :underwriting_fee_buyout
      row :lender_compensation
      row :broker do
        "#{form.broker_first_name} #{form.broker_last_name}"
      end
      row :broker_phone
      row :broker_email
      row :processor do
        "#{form.processor_first_name} #{form.processor_last_name}"
      end
      row :processor_phone
      row :processor_email
      row :address
      row :city
      row :state do
        form.state.name
      end
      row :zip
      row :borrower do
        "#{form.borrower_first_name} #{form.borrower_first_name}"
      end
      row :borrower_email
      row :borrower_mid_fico_score
      row :coborrower do
        "#{form.coborrower_first_name} #{form.coborrower_first_name}"
      end
      row :coborrower_email
      row :coborrower_mid_fico_score
      row :property_value
      row :loan_amount
      row :disclosed_rate_pct
      row :ltv
      row :cltv
      row :impounds_or_escrows
      row :loan_type
      row :transaction_type
      row :fha_underwriting_type
      row :term
      row :property_type
      row :appraisal_needed
      row :occupancy
      row :additional_details
      row :gfe_file do
        link_to("Download file", form.gfe_file.url, target: "_blank") if form.gfe_file.present?
      end
      row :fee_worksheet do
        link_to("Download file", form.fee_worksheet.url, target: "_blank") if form.fee_worksheet.present?
      end
    end
  end

  index do
    column :date do |form|
      form.pretty_date
    end
    column :broker do |form|
      "#{form.broker_first_name} #{form.broker_last_name}"
    end
    column :borrower do |form|
      "#{form.borrower_first_name} #{form.borrower_first_name}"
    end
    column :coborrower do |form|
      "#{form.coborrower_first_name} #{form.coborrower_first_name}"
    end
    actions
  end
end