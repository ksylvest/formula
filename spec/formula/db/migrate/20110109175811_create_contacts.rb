class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :group_id
      
      t.string :name
      t.text :details
      t.string :phone
      t.string :email
      t.string :url
      
      t.string :avatar_identifier
      t.string :avatar_extension

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
