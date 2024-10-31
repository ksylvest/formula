# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.2]
  def change
    create_table :contacts do |t|
      t.references :group

      t.string :name, null: false
      t.text :details, null: false

      t.string :phone, null: false
      t.string :email, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
