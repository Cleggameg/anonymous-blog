class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :content
    end
  end
end
