class RenameEventImageLinkToImage < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :image_link, :image
  end
end
