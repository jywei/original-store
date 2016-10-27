require "faker"

FactoryGirl.define do
  factory :product do
    title       { "macbook" }
    price       { "60000" }
    quantity    { "5" }
    body { "Apple" }
  end
end
