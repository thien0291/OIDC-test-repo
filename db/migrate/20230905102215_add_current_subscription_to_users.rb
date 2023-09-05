class AddCurrentSubscriptionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_subscription, :string
  end
end
