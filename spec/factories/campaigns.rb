# Key thing to remember is that factories should always provide a set of valid
# attributes which means factories should always create a record with no
# validation errors.
FactoryGirl.define do
  factory :campaign do
    association :user, factory: :user
    # You put the attribute you want to assign as a variable/method (such as name)
    # then you put the value that you want the factory to assign to that attribute
    # if you give the value without a block, it's going to be the same for all
    # objects generated bu the factory. If you put the code in a block, then
    # it will execute the code inside everytime which means if you use something
    # like faker you're likely to get a different value every time.
    # To be 100% sure taht it has to be unique then you use 'sequence'
    sequence(:name)          {|n| "#{Faker::Company.bs}-#{n}"}
    sequence(:description)   {|n| "#{Faker::Lorem.paragraph}-#{n}"}
    goal          10000000
    end_date      60.days.from_now
  end
end
