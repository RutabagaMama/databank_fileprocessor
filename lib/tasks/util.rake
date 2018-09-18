namespace :util do
  desc 'destroy all'
  task destroy_all: :environment do
    Task.all.destroy_all
    MessageIn.all.destroy_all
    MessageOut.all.destroy_all
    Problem.all.destroy_all
  end
end