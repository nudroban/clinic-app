# frozen_string_literal: true

ActiveAdmin.register Appointment do
  permit_params :doctor_id, :patient_id, :date, :time, :notes, :active

  index do
    selectable_column
    id_column
    column :doctor
    column :patient
    column :date
    column :time
    column :notes
    column :active
    actions
  end

  filter :date
  filter :doctor
  filter :patient
  filter :active

  form do |f|
    f.inputs do
      f.input :doctor, as: :select, collection: User.doctors
      f.input :patient, as: :select, collection: User.patients
      f.input :date
      f.input :time
      f.input :notes
      f.input :active
    end
    f.actions
  end
end
