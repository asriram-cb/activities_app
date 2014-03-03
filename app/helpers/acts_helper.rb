module ActsHelper

  include ActionView::Helpers::DateHelper

  def minutes_in_words(minutes)
    distance_of_time_in_words(Time.at(0), Time.at(minutes * 60))
  end

  def total_calories(as)
    act_calories = as.collect do |a|
      if a.activity_id != nil && a.activity != nil
        a.activity.calories
      else
        0
      end
    end
    act_calories.reduce(:+)
  end
end
