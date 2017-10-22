class AddAuthorizationToLanguage < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :auth_token, :text
  end
end
