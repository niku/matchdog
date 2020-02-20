require "test_helper"
require "rack/test"

class MatchdogTest < Minitest::Test
  include Rack::Test::Methods

  class App
    using Matchdog

    def call(env)
      case env
        in {REQUEST_METHOD: "GET", PATH_INFO: "/"}
        [200, {}, ["This is the root directory."]]
        in {REQUEST_METHOD: "GET", PATH_INFO: path}
        [200, {}, [path]]
        in {REQUEST_METHOD: "POST", "rack.input": input}
        [200, {}, [input.read]]
      end
    end
  end

  def app
    App.new
  end

  def test_get_root_path
    get "/"

    assert last_response.ok?
    assert_equal last_response.body, "This is the root directory."
  end

  def test_get_non_root_path
    get "/hello"

    assert last_response.ok?
    assert_equal last_response.body, "/hello"
  end

  def test_post
    post "/", "You will receive this message."


    assert last_response.ok?
    assert_equal last_response.body, "You will receive this message."
  end
end
