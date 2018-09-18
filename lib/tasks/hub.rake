namespace :hub do

  desc 'get and handle incoming messages'
  task handle_messages: :environment do
    MessageIn.get_messages
    Task.handle_new_tasks
    Peek.send_messages
    NestedItem.send_messages
  end

end