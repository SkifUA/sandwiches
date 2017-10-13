class GoogleServiceScript
  require 'google/apis/script_v1'

  def initialize(user, spreadsheet_id, name_page = 'NewSheet')
    @script_id = '1DYE6Y_QrJgf_pAo9GxkJWYOJpScYNxyYQwqsgpHeOyuJ-1_oXTgTkQXf'
    @spreadsheet_id = spreadsheet_id
    @secrets = GoogleClientSecrets.secrets(user)
    @name_page = name_page
  end

  def service
    client = Google::Apis::ScriptV1::ScriptService.new
    client.authorization = @secrets.to_authorization
    client.authorization.grant_type = 'refresh_token'
    client.authorization.refresh!
    client
  end

  def script
    request = Google::Apis::ScriptV1::ExecutionRequest.new(
        function: 'createNewSheet',
        parameters: [ @spreadsheet_id, @name_page]
    )

    begin
      resp = service.run_script(@script_id, request)

      if resp.error
        error = resp.error.details[0]
        puts "Script error message: #{error['errorMessage']}"

        if error['scriptStackTraceElements']
          puts "Script error stacktrace:"
          error['scriptStackTraceElements'].each do |trace|
            puts "\t#{trace['function']}: #{trace['lineNumber']}"
          end
        end
      else
        folder_set = resp.response['result']
        if folder_set.length == 0
          puts "No folders returned!"
        else
          puts "Folders under your root folder:"
          folder_set.each do |id, folder|
            puts "\t#{folder} (#{id})"
          end
        end
      end
    rescue Google::Apis::ClientError # The API encountered a problem before the script started executing.
      puts "Error calling API!"
    end
  end
end
