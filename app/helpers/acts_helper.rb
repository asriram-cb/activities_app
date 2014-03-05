module ActsHelper

  include ActionView::Helpers::DateHelper

  def minutes_in_words(minutes)
    distance_of_time_in_words(Time.at(0), Time.at(minutes * 60))
  end

  def total_calories(as)
    act_calories = as.collect do |a|
      if a.calories == nil
        0
      else
        a.calories
      end
    end
    act_calories.reduce(:+)
  end

  def recent_activities
    Act.order(completed: :desc).limit(5)
  end
end
