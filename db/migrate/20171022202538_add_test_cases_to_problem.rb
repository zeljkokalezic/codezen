class AddTestCasesToProblem < ActiveRecord::Migration[5.1]
  def change
    add_column :problems, :test_cases, :text
  end
end
