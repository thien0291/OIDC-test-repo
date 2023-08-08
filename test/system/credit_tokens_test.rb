require "application_system_test_case"

class CreditTokensTest < ApplicationSystemTestCase
  setup do
    @credit_token = credit_tokens(:one)
  end

  test "visiting the index" do
    visit credit_tokens_url
    assert_selector "h1", text: "Credit tokens"
  end

  test "should create credit token" do
    visit credit_tokens_url
    click_on "New credit token"

    fill_in "Cancelled at", with: @credit_token.cancelled_at
    fill_in "Daily threshold", with: @credit_token.daily_threshold
    fill_in "Expired at", with: @credit_token.expired_at
    fill_in "Hourly threshold", with: @credit_token.hourly_threshold
    fill_in "Monthly threshold", with: @credit_token.monthly_threshold
    fill_in "Provider", with: @credit_token.provider
    fill_in "Threshold", with: @credit_token.threshold
    fill_in "Token", with: @credit_token.token
    fill_in "Transaction threshold", with: @credit_token.transaction_threshold
    fill_in "User", with: @credit_token.user_id
    fill_in "Weekly threshold", with: @credit_token.weekly_threshold
    click_on "Create Credit token"

    assert_text "Credit token was successfully created"
    click_on "Back"
  end

  test "should update Credit token" do
    visit credit_token_url(@credit_token)
    click_on "Edit this credit token", match: :first

    fill_in "Cancelled at", with: @credit_token.cancelled_at
    fill_in "Daily threshold", with: @credit_token.daily_threshold
    fill_in "Expired at", with: @credit_token.expired_at
    fill_in "Hourly threshold", with: @credit_token.hourly_threshold
    fill_in "Monthly threshold", with: @credit_token.monthly_threshold
    fill_in "Provider", with: @credit_token.provider
    fill_in "Threshold", with: @credit_token.threshold
    fill_in "Token", with: @credit_token.token
    fill_in "Transaction threshold", with: @credit_token.transaction_threshold
    fill_in "User", with: @credit_token.user_id
    fill_in "Weekly threshold", with: @credit_token.weekly_threshold
    click_on "Update Credit token"

    assert_text "Credit token was successfully updated"
    click_on "Back"
  end

  test "should destroy Credit token" do
    visit credit_token_url(@credit_token)
    click_on "Destroy this credit token", match: :first

    assert_text "Credit token was successfully destroyed"
  end
end
