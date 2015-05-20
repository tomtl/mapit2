Fabricator(:location) do
  address do
    street = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state
    zip = Faker::Address.postcode
    [street, city, state, zip].join(" ")
  end
end