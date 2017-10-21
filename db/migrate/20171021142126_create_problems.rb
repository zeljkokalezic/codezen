class CreateProblems < ActiveRecord::Migration[5.1]
  def change
    create_table :problems do |t|
      t.text :text
      t.string :function_name
      t.references :language, foreign_key: true
      t.references :user, foreign_key: true
      t.text :setup

      t.timestamps
    end
  end
end
