require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "",
                                         password: "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Anakin",
                                         email: "vader@empire.com",
                                         password: "foobar",
                                         password_confirmation: "foobar" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end

end
