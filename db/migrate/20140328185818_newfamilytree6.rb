class Newfamilytree6 < ActiveRecord::Migration
  def change
    rename_table :married, :marriages
  end
end
