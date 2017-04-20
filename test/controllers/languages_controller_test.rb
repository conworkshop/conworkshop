# frozen_string_literal: true
require 'test_helper'

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get languages_show_url
    assert_response :success
  end

  test 'should get new' do
    get languages_new_url
    assert_response :success
  end

  test 'should get create' do
    get languages_create_url
    assert_response :success
  end

  test 'should get edit' do
    get languages_edit_url
    assert_response :success
  end

  test 'should get update' do
    get languages_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get languages_destroy_url
    assert_response :success
  end
end
