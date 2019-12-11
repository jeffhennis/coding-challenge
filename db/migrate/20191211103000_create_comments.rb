class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :post
      t.string :comment
      t.timestamps
    end
  end
end
