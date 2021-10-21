module ApiHelper
  def json_response_body
    JSON.parse(response.body, symbolize_names: true)
  rescue StandardError => _e
    {}
  end
end
