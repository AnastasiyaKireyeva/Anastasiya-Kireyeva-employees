# frozen_string_literal: true

# Class for result formatting
class ResultFormatter
  def self.format(pair)
    projects_info = pair.projects.map { |project_id, days| "\nProject ID: #{project_id}, Days worked: #{days}" }.join
    "Employees #{pair.employee1} and #{pair.employee2} worked together the " \
    "longest for a total of #{pair.total_days} days.#{projects_info}"
  end
end
