class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name, default: ''
      t.string :description, default: ''
      t.string :organizer, default: ''
      t.date :date
      t.string :image_link
      t.integer :user_id

      t.timestamps
    end
    add_index :events, :user_id
  end
end
