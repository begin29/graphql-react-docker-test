class MakeStoryIdNotRequired < ActiveRecord::Migration[6.0]
  def change
    change_column :articles, :story_id, :bigint, null: true
  end
end
