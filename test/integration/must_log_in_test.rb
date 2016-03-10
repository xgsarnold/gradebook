require 'test_helper'

class MustLogInTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "teacher workflow" do
    #Login works
    get root_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template "new"
    assert_select "#notice", 1
    assert_select "input[type=email]", 1
    assert_select "input[type=password]", 1
    post login_path email: "mason@example.com", password: "password"
    assert_redirected_to root_path
    follow_redirect!

    #Make sure that I can see teachers
    assert_select "tbody tr", Teacher.count

    #Create a teacher
    get new_teacher_path
    post teachers_path teacher: {name: "Kelly", email: "kelly@mail.com", password: "password" }


    #Make sure that I see one more.
    get root_path
    assert_select "tbody tr", Teacher.count

    #Log out
    delete logout_path

    # Make sure I go to the login page.
    assert_redirected_to login_path
    follow_redirect!

  end

  test "student workflow" do
    get root_path
    assert_redirected_to login_path
    follow_redirect!
    post login_path email: "geoff@mail.com", password: "password"
    assert_redirected_to grades_path
    follow_redirect!

    #Make sure that I can see grades
    # assert_select "tbody tr", Grade.count - 1

    #Log out
    delete logout_path

    # Make sure I go to the login page.
    assert_redirected_to login_path
    follow_redirect!

  end

  test "parent workflow" do
    get root_path
    assert_redirected_to login_path
    follow_redirect!
    post login_path email: "dad@mail.com", password: "password"
    assert_redirected_to grades_path
    # follow_redirect!

    #Make sure that I can see grades
    # assert_select "tbody tr", Grade.count - 1

    #Log out
    delete logout_path

    # Make sure I go to the login page.
    assert_redirected_to login_path
    follow_redirect!

  end
end
