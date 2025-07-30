# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :doctor,  null: false, foreign_key: { to_table: :users }
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.date :date
      t.time :time
      t.text :notes
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :appointments, %i[doctor_id date time], unique: true
  end
end
