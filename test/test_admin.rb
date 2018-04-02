require 'cuba/test'
require_relative '../app'
scope do
  test 'Admin' do
    get '/admin'
    assert_equal "", last_response.body
  end
end
