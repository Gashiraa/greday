class Company < ApplicationRecord
  after_create :create_tenant
  has_many :customers

  private

  def create_tenant
    Apartment::Tenant.create(Company.find(id).name)
  end
end