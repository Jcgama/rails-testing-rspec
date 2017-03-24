FactoryGirl.define do
    factory :product do |f|
        f.title "Asdf"
        f.description "Foooooooo"
        f.image_url "foo.jpg"
        f.price 666.00
    end
    
    factory :invalid_product, parent: :product do |f|
        f.title nil
    end
    
end