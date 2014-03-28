class Newfamilytree2 < ActiveRecord::Migration
  def change
    rename_table :persons, :people
  end
end
