class MessageIn < ApplicationRecord
  def self.queue
    APP_CONFIG['messages']['incoming_queue']
  end


  def self.get_messages
    config = (APP_CONFIG['amqp'] || {}).symbolize_keys

    config.merge!(recover_from_connection_close: true)

    conn = Bunny.new(config)
    conn.start

    ch = conn.create_channel
    q = ch.queue("idb_to_fp", :durable => true)
    x = ch.default_exchange

    has_payload = true

    while has_payload
      delivery_info, properties, payload = q.pop
      if payload.nil?
        has_payload = false
      else
        message_in = MessageIn.create(content: payload)
        message_in.message_to_task
      end
    end
    conn.close
  end

  def message_to_task

    if self.content && self.content != ""
      task_hash = JSON.parse(self.content)
      if task_hash.has_key?('operation') &&
          ['process', 'cancel'].include?(task_hash['operation']) &&
          task_hash.has_key?('storage_root') &&
          task_hash.has_key?('storage_key') &&
          task_hash.has_key?('dataset_id') &&
          task_hash.has_key?('datafile_id') &&
          task_hash.has_key?('binary_name')
        Task.create!(operation:task_hash['operation'],
                     storage_root: task_hash['storage_root'],
                     storage_key: task_hash['storage_key'],
                     dataset_id: task_hash['dataset_id'].to_i,
                     datafile_id: task_hash['datafile_id'].to_i,
                     binary_name: task_hash['binary_name'] )
      else
        Problem.report("Invalid message from databank: #{task_hash.to_yaml}")
      end

    else
      Problem.report("Missing content for MessageIn: #{self.id}")
    end

  end

  def add(response_hash)
    raise "not yet implemented"
  end

  def remove(response_hash)
    raise "not yet implemented"
  end

end
