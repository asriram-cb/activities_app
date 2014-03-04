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

  def calculate_calories(user, activity, minutes)
    cal = user.gender == "female" ? ( (user.age * 0.074) - (user.weight * 0.05741) + (activity.heart_rate * 0.4472) - 20.4022) * minutes / 4.184 : ( (user.age * 0.2017) + (user.weight * 0.09036) + (activity.heart_rate * 0.6309) - 55.0969) * minutes / 4.184
    # taken from http://fitnowtraining.com/2012/01/formula-for-calories-burned/
    cal.round(0)
  end

  def recent_activities
    Act.order(completed: :desc).limit(5)
  end
end
