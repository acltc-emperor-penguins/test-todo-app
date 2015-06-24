require 'rails_helper'

RSpec.describe Task, type: :model do

  describe '#toggle_complete!' do
    it 'should make an incomplete task complete' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end

    it 'should make a complete task incomplete' do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
  end

  describe '#toggle_favorite!' do
    it 'should make a non-favorite task into a favorite task' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end

    it 'should make a favorite task into a non-favorite task' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'should increment priority by one' do
      task = Task.create(priority: 4)
      task.increment_priority!
      expect(task.priority).to eq(5)
    end

    it 'should not increment priority if priority is already at 10' do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#overdue?' do
    it 'should return true if deadline has already passed' do
      task = Task.create(deadline: 1.day.ago)
      result = task.overdue?
      expect(result).to eq(true)
    end

    it 'should return false if deadline is still in the future' do
      task = Task.create(deadline: 1.day.from_now)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#snooze_hour!' do
    it 'should push the deadline off by one hour' do
      task = Task.create(deadline: Time.new(2000, 1, 1))
      task.snooze_hour!
      expect(task.deadline).to eq(Time.new(2000, 1, 1) + 1.hour)
    end
  end

end
