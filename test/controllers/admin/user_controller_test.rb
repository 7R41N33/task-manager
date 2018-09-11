require 'test_helper'

class Admin::UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    admin = create(:admin)
    sign_in_as admin
  end

  test 'should post create' do
    user = attributes_for(:developer)
    post admin_users_url, params: { user: user }
    assert_response :redirect
  end

  test 'should delete destroy' do
    user = create(:developer)
    delete admin_user_url user.id
    assert_response :redirect
  end

  test 'should get edit' do
    user = create(:developer)
    get edit_admin_user_url user.id
    assert_response :success
  end

  test 'should get index' do
    get admin_users_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_user_url
    assert_response :success
  end

  test 'should get show' do
    get admin_users_url
    assert_response :success
  end

  test 'should patch update' do
    user = create(:developer)
    user_attrs = attributes_for(:developer)
    patch admin_user_url user.id, params: { user: user_attrs }
    assert_response :redirect
  end
end
