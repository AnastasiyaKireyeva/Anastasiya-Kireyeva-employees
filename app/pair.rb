# frozen_string_literal: true

# Pair class
class Pair
  attr_reader :employee1, :employee2, :projects

  def initialize(employee1, employee2)
    @employee1 = employee1
    @employee2 = employee2
    @projects = Hash.new(0)
  end

  def add_project(project_id, days)
    projects[project_id] += days
  end

  def total_days
    projects.values.sum
  end
end
