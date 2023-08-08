require "test_helper"

class CreditTokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credit_token = credit_tokens(:one)
  end

  test "should get index" do
    get credit_tokens_url
    assert_response :success
  end

  test "should get new" do
    get new_credit_token_url
    assert_response :success
  end

  test "should create credit_token" do
    assert_difference("CreditToken.count") do
      post credit_tokens_url, params: { credit_token: { cancelled_at: @credit_token.cancelled_at, daily_threshold: @credit_token.daily_threshold, expired_at: @credit_token.expired_at, hourly_threshold: @credit_token.hourly_threshold, monthly_threshold: @credit_token.monthly_threshold, provider: @credit_token.provider, threshold: @credit_token.threshold, token: @credit_token.token, transaction_threshold: @credit_token.transaction_threshold, user_id: @credit_token.user_id, weekly_threshold: @credit_token.weekly_threshold } }
    end

    assert_redirected_to credit_token_url(CreditToken.last)
  end

  test "should show credit_token" do
    get credit_token_url(@credit_token)
    assert_response :success
  end

  test "should get edit" do
    get edit_credit_token_url(@credit_token)
    assert_response :success
  end

  test "should update credit_token" do
    patch credit_token_url(@credit_token), params: { credit_token: { cancelled_at: @credit_token.cancelled_at, daily_threshold: @credit_token.daily_threshold, expired_at: @credit_token.expired_at, hourly_threshold: @credit_token.hourly_threshold, monthly_threshold: @credit_token.monthly_threshold, provider: @credit_token.provider, threshold: @credit_token.threshold, token: @credit_token.token, transaction_threshold: @credit_token.transaction_threshold, user_id: @credit_token.user_id, weekly_threshold: @credit_token.weekly_threshold } }
    assert_redirected_to credit_token_url(@credit_token)
  end

  test "should destroy credit_token" do
    assert_difference("CreditToken.count", -1) do
      delete credit_token_url(@credit_token)
    end

    assert_redirected_to credit_tokens_url
  end
end
