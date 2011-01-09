class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.text :details
      t.string :phone
      t.string :email
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
