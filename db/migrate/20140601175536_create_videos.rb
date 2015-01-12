class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.references :topic
    	t.string :url
    	t.string :channel
    	t.string :title
    	t.text :description
      t.timestamps
    end
  end
end
