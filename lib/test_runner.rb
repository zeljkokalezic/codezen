require 'rest-client'

class TestRunner

  def run(problem, user, code, input)
    run_status = {
        :passed => false,
        :score => 0
    }

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

    passed_test_cases = 0
    total_test_cases = problem.test_cases.each_line.count

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
          passed_test_cases += 1
        else
          send_status_message(problem, user, "Test case failed: #{test_case}")
        end
      else
        send_status_message(problem, user, "Test case invalid: #{test_case}")
      end
    end

    send_status_message(problem, user, "Execution finished.")

    run_status[:passed] = passed_test_cases == total_test_cases
    run_status[:score] = passed_test_cases.to_f / total_test_cases * 100 rescue 0

    run_status
  end
  handle_asynchronously :run, :priority => 0

  def submit_run(problem, user, code, input)
    run_status = run_without_delay(problem, user, code, input)

    send_status_message(problem, user, "Saving solution...")
    solution = Solution.new(:user => user, :code => code, :problem => problem, :status => run_status[:passed] ? 1 : 0, :score => run_status[:score])
    if solution.save
      send_status_message(problem, user, "Solution saved:#{solution.to_json}")
    else
      send_status_message(problem, user, "Unable to save solution: #{solution.to_json}")
    end
  end
  handle_asynchronously :submit_run, :priority => 0

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