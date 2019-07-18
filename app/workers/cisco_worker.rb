class CiscoWorker
  include Sidekiq::Worker

  def perform(*args)
    application_name = Rails.application.class.parent_name
    application = Object.const_get(application_name)
    application::Application.load_tasks
    Rake::Task['update:computers'].invoke
  end
end
