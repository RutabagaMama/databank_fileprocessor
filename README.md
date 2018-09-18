# Illinois Data Bank Fileprocessor

Manages file processing tasks to extract preview text and information about files nested in container files.

Web interface supports monitoring and management of tasks as triggered by messages from Illinois Data Bank through a RabbitMQ server.

Depends on cron job to trigger script to run task hub:handle_messages.

