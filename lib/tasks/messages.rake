namespace :messages do

  desc 'send test messages'
  task mock_messages: :environment do

    msg1 = Hash.new
    msg1['storage_root'] = 'draft'
    msg1['storage_key'] = 'u1gfl/monk-wiki.zip'
    msg1['dataset_id'] = '2'
    msg1['datafile_id'] = '17'
    msg1['binary_name'] = 'monk-wiki.zip'
    msg1['operation'] = 'process'
    connector = AmqpConnector.instance
    in_queue = MessageIn.queue
    if connector && in_queue
      connector.send_message(in_queue, msg1)
    else
      raise("no connector or in queue in rake task")
    end

    msg2 = Hash.new
    msg2['storage_root'] = 'draft'
    msg2['storage_key'] = 'u1gfl/monk-wiki.zip'
    msg2['dataset_id'] = '2'
    msg2['datafile_id'] = '17'
    msg2['binary_name'] = 'monk-wiki.zip'
    msg2['operation'] = 'process'
    if connector && in_queue
      connector.send_message(in_queue, msg2)
    end

  end

  desc 'get messages'
  task get_messages: :environment do
    MessageIn.get_messages
  end

  desc 'create test Problem'
  task make_problem: :environment do
    Problem.report("test")
  end

  desc 'create test Task'
  task make_task: :environment do
    Task.create!(operation: 'process',
                 storage_root: 'draft',
                 storage_key: 'd6iv1/monk-website-files.zip',
                 dataset_id: 2,
                 binary_name: 18 )
  end



end