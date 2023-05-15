# frozen_string_literal: true

class ProgressTasksLogger
  attr_accessor :total_count, :current_count

  def initialize(total_count:)
    @total_count = total_count
    @current_count = 0
  end

  def reset
    self.current_count = 0
  end

  def increment(value: 1)
    self.current_count += value
  end

  def progress_string
    "(#{current_count}/#{total_count})"
  end
end
