class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :name, unique: true, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
