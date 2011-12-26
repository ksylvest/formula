class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :group
      
      t.string :name
      t.string :slug
      t.text :details
      
      t.string :phone
      t.string :email
      t.string :url
      
      t.string :avatar_identifier
      t.string :avatar_extension
      t.integer :avatar_size

      t.timestamps
    end
  end
end
