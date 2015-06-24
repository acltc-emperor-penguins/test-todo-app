class List < ActiveRecord::Base
  has_many :tasks

  def complete_all_tasks!
    tasks.update_all(complete: true)
  end

  def snooze_all_tasks!
    tasks.each do |task|
      task.snooze_hour!
    end
  end

  def total_duration
    total = 0
    tasks.each do |task|
      total += task.duration
    end
    return total
  end

  def incomplete_tasks
    tasks = []
    tasks.each do |task|
      if !task.complete
        tasks << task
      end
    end
    return tasks
  end

  def favorite_tasks
    tasks = []
    tasks.each do |task|
      if task.favorite
        tasks << task
      end
    end
    return tasks
  end
end
