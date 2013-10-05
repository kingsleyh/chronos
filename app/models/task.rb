class Task < ActiveRecord::Base

  belongs_to :project

  validates :name, presence: true

  def self.authorised_for_user(user_id)
    user = User.find(user_id)
    tasks = user.authorised_tasks
    result = []
    if !tasks.nil?
      tasks = tasks.uniq.compact.reject! { |t| t.empty? }
      begin
        list = tasks.collect { |id| Task.find(id) }
        result = list.empty? ? [] : list
      rescue => e
        p e
      end
    end
    result
  end

end
