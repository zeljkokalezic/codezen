class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.string :descriptor
      t.string :service_url

      t.timestamps
    end
  end
end
