class Problem < ApplicationRecord
  def self.report(message)
    Problem.create(report: message)
  end
end
