class AddNewInfoReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :phone_number, :string
    add_column :reviews, :ambiance, :string
  end
end
