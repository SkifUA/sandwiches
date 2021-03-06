class GoogleServiceSheets
  require 'google/apis/sheets_v4'
  attr_accessor :name_page

  def initialize(user, sheets_id, name_page = 'template')
    @spreadsheet_id = sheets_id
    @secrets = GoogleClientSecrets.secrets(user)
    @name_page = name_page
    @user = user
  end

  def service
    client = Google::Apis::SheetsV4::SheetsService.new
    client.authorization = @secrets.to_authorization
    client.authorization.grant_type = 'refresh_token'
    client.authorization.refresh!
    client
  end

  def create
    response = service.create_spreadsheet

    puts response.to_json
  end

  def update(user, objects, period)
    rows = [[user.name,'']]
    rows << ["#{period.start_date} - #{period.finish_date}", "#{period.days} days"]
    objects.each { |object| rows << row_for_sheets(object) }
    rows = add_empty_rows(rows)

    range = "#{@name_page}!A2:B#{rows.count + 1}"
    value_range_object = {
        range: "#{@name_page}!A2:B#{rows.count + 1}",
        major_dimension: "ROWS",
        values: rows
    }

    response = service.update_spreadsheet_value(
        @spreadsheet_id,
        range,
        value_range_object,
        include_values_in_response: true,
        value_input_option: 'USER_ENTERED'
    )
    puts response.to_json
  end

  private

  def row_for_sheets(object)
    [object.name, object.quantity]
  end

  def add_empty_rows(rows)
    15.times { rows << ['',''] }
    rows
  end
end