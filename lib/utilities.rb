module Utilities

  def self.calculate_calories(user, activity, minutes)
    if params_present_to_calc_calories?(user, activity, minutes)
      cal = user.gender == "female" ? ( (user.age * 0.074) - (user.weight * 0.05741) + (activity.heart_rate * 0.4472) - 20.4022) * minutes / 4.184 : ( (user.age * 0.2017) + (user.weight * 0.09036) + (activity.heart_rate * 0.6309) - 55.0969) * minutes / 4.184
    # taken from http://fitnowtraining.com/2012/01/formula-for-calories-burned/
      cal.round(0)
    else
      1
    end
  end

  def self.complete_user?(user)
    !user.age.blank? && !user.weight.blank? && !user.gender.blank?
  end

  def self.params_present_to_calc_calories?(user, activity, minutes)
    complete_user?(user) && !activity.blank? && !minutes.blank?
  end
end