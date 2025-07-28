# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :first_name, :last_name, :phone, :role, :category_id, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :phone
    column :role
    column :category
    actions
  end

  filter :role
  filter :category

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :role, as: :select, collection: User.roles.keys
      f.input :category
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
