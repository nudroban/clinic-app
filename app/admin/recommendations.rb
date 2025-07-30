# frozen_string_literal: true

ActiveAdmin.register Recommendation do
  permit_params :appointment_id, :content

  index do
    selectable_column
    id_column
    column :appointment
    column :content
    actions
  end

  filter :appointment
  filter :content

  form do |f|
    f.inputs do
      f.input :content
      f.input :appointment, as: :select, collection: Appointment.all,
                            member_label: :display_name
    end
    f.actions
  end
end