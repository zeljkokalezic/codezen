require 'rest-client'

class TestRunner

  def run(problem, user, code, input)
    params = {
        :function => Base64.encode64(code),
        :function_name => problem.function_name,
        :params => input
    }

    ActionCable.server.broadcast "test#{problem.id}#{user.id}", message: "Preparing execution..."

    response = RestClient.post(
        problem.language.service_url,
        params,
        {'Authorization': "Token token=#{problem.language.auth_token}"}
    ) {|response, request, result|  response }

    ActionCable.server.broadcast "test#{problem.id}#{user.id}", message: "Executed. Result is: #{response}"
  end
  handle_asynchronously :run, :priority => 0

end