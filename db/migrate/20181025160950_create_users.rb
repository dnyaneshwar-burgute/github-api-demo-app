# frozen_string_literal: true

# migration for users
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :login
      t.string :email
      t.string :image_url

      t.timestamps
    end
  end
end
