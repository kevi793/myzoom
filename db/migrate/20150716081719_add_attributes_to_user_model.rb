class AddAttributesToUserModel < ActiveRecord::Migration
  def up
    remove_column("users", :name)
    add_column("users", :first_name, :string, :limit => 25, :null => false)
    add_column("users", :last_name, :string, :limit => 25, :null => false)
    add_column("users", :email, :string, :null => false, :limit => 100)
    add_column("users", :password_digest, :string, :limit => 60)
  end
  def down
    remove_column("users",:password_digest)
    remove_column("users",:email)
    remove_column("users",:last_name)
    remove_column("users",:first_name)
    add_column("users", :name, :string)
  end
end
