class AddPolymorphicAssociationToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :related_object, polymorphic: true, null: false, type: :uuid, index: true
    remove_reference :transactions, :article
  end
end
