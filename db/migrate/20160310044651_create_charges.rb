class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string :email
      t.string :source
      t.belongs_to :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
