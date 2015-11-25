class RolifyCreateRoles < ActiveRecord::Migration
  def change

    add_index(:roles, [:name, :resource_type, :resource_id])

  end
end
