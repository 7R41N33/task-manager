require 'test_helper'

class Web::BoardControllerTest < ActionDispatch::IntegrationTest
  test 'should get show redirect if not auth' do
    get board_url
    assert_response :redirect
  end

  test 'should get show' do
    admin = create(:admin)
    sign_in_as admin

    get board_url
    assert_response :success
  end
end
