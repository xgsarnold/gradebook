require 'test_helper'

class MustLogInTest < ActionDispatch::IntegrationTest
  test "login works well" do
    get root_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template "new"
    assert_select "#notice", 1
    assert_select "input[type=email]", 1
    assert_select "input[type=password]", 1

    #Log in
    post login_path email: "mason@example.com", password: "password"
    assert_redirected_to root_path
    follow_redirect!

    #Make sure that I can see teachers
    assert_select "tbody tr", Teacher.count

    #Create a teacher

    #Make sure that I see one more.

    # Log out

    # Make sure I go to the login page.
  end
end
