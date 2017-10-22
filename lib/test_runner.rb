require 'rest-client'

class TestRunner

  def run(problem, user, code, input)
    params = {
        :function => Base64.encode64(code),
        :function_name => problem.function_name,
        :params => input
    }

    send_status_message(problem, user, "Preparing execution...")
    send_status_message(problem, user, "Executing user test input...")
    response = execute_on_remote_server(params, problem)
    send_status_message(problem, user, "Executed. Result is: #{response}")

    send_status_message(problem, user, "Executing test cases...")
    problem.test_cases.each_line do |test_case|
      test_case.strip!

      send_status_message(problem, user, "Executing test case: #{test_case}")

      data = test_case.split("=>")

      if data.count == 2
        input = data[0].strip.tr('[]', '')
        output = data[1].strip.tr('[]', '')

        params[:params] = input
        response = execute_on_remote_server(params, problem)
        send_status_message(problem, user, "Executed test case: #{test_case}. Result is: #{response}")

        if response.to_s == output.to_s
          send_status_message(problem, user, "Test case passed: #{test_case}")
        else
          send_status_message(problem, user, "Test case failed: #{test_case}")
        end
      else
        send_status_message(problem, user, "Test case invalid: #{test_case}")
      end
    end

    send_status_message(problem, user, "Execution finished.")
  end
  handle_asynchronously :run, :priority => 0

  private

  def execute_on_remote_server(params, problem)
    RestClient.post(
        problem.language.service_url,
        params,
        {'Authorization': "Token token=#{problem.language.auth_token}"}
    ) { |response, request, result| response }
  end

  def send_status_message(problem, user, message)
    ActionCable.server.broadcast channel_descriptor(problem, user), message: message
  end

  def channel_descriptor(problem, user)
    "test#{problem.id}#{user.id}"
  end

end