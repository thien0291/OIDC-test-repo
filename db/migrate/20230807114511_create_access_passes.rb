class CreateAccessPasses < ActiveRecord::Migration[7.0]
  def change
    create_table :access_passes, id: :uuid do |t|
      t.string :package_name, null: false, default: "1 day"
      t.datetime :valid_from
      t.datetime :valid_until

      t.timestamps
    end
  end
end
