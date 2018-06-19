class AddFieldsToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :name, :string
    add_column :images, :imageable_id, :integer
    add_column :images, :imageable_type, :string
  end
end
