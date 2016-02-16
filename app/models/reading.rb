class Reading < ActiveRecord::Base
  belongs_to :course_element



  def self.give_permissions

    puts "Start to share readings at: #{Time.now.strftime('%d/%m/%Y %I:%M %p')}}"

    Period.all.each do |period|

      if Time.now >= period.commence_datetime - 3.hours && Time.now < period.commence_datetime - 2.hours
        puts "alert time: #{(period.commence_datetime - 3.hours).strftime('%d/%m/%Y %I:%M %p')})"
        puts "#{period.title} is today, time for lesson: #{period.commence_datetime.strftime('%d/%m/%Y %I:%M %p')}"
        client = Google::APIClient.new
        perm_type = 'user'
        role = 'reader'
        value = []

        period.group.students.each do |student|
          UserMailer.invitation_to_period_event(student, period).deliver
          puts "Mail sent to #{student.full_name}"
          value.push student.email
        end
        period.course_element.readings.each do |file|
          Reading.insert_google_permission(client, file.file_id, value, perm_type, role)
        end
      end
    end
  end

  def self.insert_google_permission(client, file_id, value, perm_type, role)

    client.authorization.access_token = Token.last.fresh_token
    drive_api = client.discovered_api('drive', 'v2')

    new_permission = drive_api.permissions.insert.request_schema.new({
                                                                         'value' => value,
                                                                         'type' => perm_type,
                                                                         'role' => role
                                                                     })
    @result = client.execute(
        :api_method => drive_api.permissions.insert,
        :body_object => new_permission,
        :parameters => { 'fileId' => file_id })

    if @result.status == 200
      puts "Success #{Time.now.strftime("%d/%m/%Y %I:%M %p")}"
      # puts @result.data
    else
      @error =  "An error occurred: #{@result.data['error']['message']}"
      puts @error
      puts " #{Time.now.strftime("%d/%m/%Y %I:%M %p")}"
    end
  end
end
