module ActsHelper

  include ActionView::Helpers::DateHelper

  def minutes_in_words(minutes)
    distance_of_time_in_words(Time.at(0), Time.at(minutes * 60))
  end
end
