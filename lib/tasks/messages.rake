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
    msg2['storage_key'] = 'd6iv1/monk-website-files.zip'
    msg2['dataset_id'] = '2'
    msg2['datafile_id'] = '18'
    msg2['binary_name'] = 'monk-website-files.zip'
    msg2['operation'] = 'process'
    if connector && in_queue
      connector.send_message(in_queue, msg2)
    end

    msg3 = Hash.new
    msg3['storage_root'] = 'draft'
    msg3['storage_key'] = 'f1250a409bfe6c731ed3b875ed1a7012'
    msg3['dataset_id'] = '11'
    msg3['datafile_id'] = '19'
    msg3['binary_name'] = 'Brain_Images.zip'
    msg3['operation'] = 'process'
    if connector && in_queue
      connector.send_message(in_queue, msg3)
    end

    msg4 = Hash.new
    msg4['storage_root'] = 'draft'
    msg4['storage_key'] = 'f42949e3f6695f462aa53c14386fd70d'
    msg4['dataset_id'] = '2'
    msg4['datafile_id'] = '17'
    msg4['binary_name'] = '15IL004_C7U2JANXX_s_7_fastq.txt.gz'
    msg4['operation'] = 'process'
    if connector && in_queue
      connector.send_message(in_queue, msg4)
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