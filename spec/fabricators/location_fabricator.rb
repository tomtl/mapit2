Fabricator(:location) do
  address do
    street = Faker::Address.street_address
    city = Faker::Address.city
    state = Faker::Address.state
    zip = Faker::Address.postcode
    sleep(0.2) # Stops Google Geocoder API returning an error for over query limit
    [street, city, state, zip].join(" ")
  end
end
