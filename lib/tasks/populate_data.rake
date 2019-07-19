namespace :update do

  desc 'updates computers data'

  # This task will make a call to CISCO API client and populate all the Computer data in DB
  task computers: :environment do
    computers = []
    Computer.delete_all
    computer_data = client.computers[:data]
    puts "*** Started creating Computer from CISCO AMP API ***"
    Computer.transaction do
      computer_data.each do |data|
        computer = Computer.new( connecter_guid: data[:connector_guid],
                                  hostname: data[:hostname],
                                  active: data[:active],
                                  connector_version: data[:connector_version],
                                  operating_system: data[:operating_system],
                                  internal_ips: data[:internal_ips],
                                  external_ip: data[:external_ip],
                                  group_guid: data[:group_guid],
                                  install_date: data[:install_date],
                                  last_seen: data[:last_seen]
                                )
        computers << computer
      end
      Computer.import computers, on_duplicate_key_update: [:hostname, :active, :connector_version, :operating_system, :internal_ips, :external_ip, :group_guid, :install_date, :last_seen]
    end
    puts "*** Completed Created #{computers.count} computers ***"
  end

  # This will call the Vulnerability service of the CISCO API
  # Will fetch the vulnarabilities of each computer and stores them to DB againist the computer record.
  task computer_vulnarabilities: :environment do
    vulnarabilities = []
    puts "*** Started populating Vulnarabilities of every computer from CISCO AMP API ***"
    Vulnarability.delete_all
    hydra = Typhoeus::Hydra.new
    Computer.find_each do |computer|
      request = client.computer_vulnarabilities(computer.connecter_guid)
      puts request
      request.on_complete do |response|
        puts response.body.inspect
        vulnarability_data = JSON.parse(response.body).with_indifferent_access[:data][:vulnerabilities]
        Vulnarability.transaction do
          vulnarability_data.each do |data|
            vulnarability = Vulnarability.new( computer_id: computer.id,
                                               application: data[:application],
                                               version: data[:version],
                                               file: data[:file],
                                               cves: data[:cves],
                                               latest_date: data[:latest_date]
                                            )
            vulnarabilities << vulnarability
          end
        end
      end
      hydra.queue(request)
    end
    hydra.run
    Vulnarability.import vulnarabilities, on_duplicate_key_update: [:computer_id, :application, :version, :file, :cves]
    puts "*** Completed populating Vulnarabilities ***"
  end

  # This task will iterate over each computer and get its user Activity
  # and strores it in the DB.
  task computer_user_activities: :environment do
    activities = []
    puts "*** Started populating User Activities ***"
    UserActivity.delete_all
    hydra = Typhoeus::Hydra.new
    Computer.find_each do |computer|
      request = client.user_trajectory(computer.connecter_guid)
      puts request
      UserActivity.transaction do
        request.on_complete do |response|
          puts response.body.inspect
          users_activity_data = JSON.parse(response.body).with_indifferent_access[:data][:events]
          users_activity_data.each do |data|
            user = User.find_by(name: data[:user_name]) || @admin
            activity = UserActivity.new( computer_id: computer.id,
                                           user_id: user.id,
                                           severity: data[:severity],
                                           event_type: data[:event_type],
                                           detection: data[:detection],
                                           detected_date: data[:date],
                                           user_name: data[:user_name],
                                           file: data[:file]
                                        )
            activities << activity
          end
        end
        hydra.queue(request)
      end
    end
    hydra.run
    activities.each_slice(500) do |activities_to_import|
      UserActivity.import activities, on_duplicate_key_update: [:computer_id, :user_id, :severity, :event_type, :detection, :detected_date, :user_name, :file]
    end
    puts "*** Completed populating User Activities ***"
  end

  # This method will create the client object to interact with CISCO API
  # This will take the Admin record and get the Authetication details strored in the AuthRecord
  # and uses them in the clent call.
  def client
    @admin ||= User.find_by(is_admin: true)
    @auth_record ||= @admin.auth_record
    @client ||= CiscoAmpApi::V1::Client.new(@auth_record.api_client, @auth_record.api_key )
  end
end
