FactoryGirl.define do
	factory :user do
		name     "Sunyoung Park"
		email    "test@example.com"
		password "foobar"
		password_confirmation "foobar"
	end 
end