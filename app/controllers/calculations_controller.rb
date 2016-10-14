class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub("\r","").gsub("\n","").gsub(" ","").length

    @word_count = @text.split.count

    @occurrences = @text.downcase.split.count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    @monthly_interest = (@apr / 12) / 100
    @months = @years * 12


    @monthly_payment = (@monthly_interest * @principal) / (1-((1+@monthly_interest)**-@months))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = (@ending-@starting).to_f
    @minutes = (@seconds / 60).to_f
    @hours = (@minutes / 60).to_f
    @days = (@hours / 24).to_f
    @weeks = (@days / 7).to_f
    @years = (@days / (((365*3)+(366))/4)).to_f

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count.to_i

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum - @minimum

    if @count.even?

      @median = (@sorted_numbers[(@count/2).to_i - 1] + @sorted_numbers[(@count/2).to_i]) / 2

    elsif @count.odd?

      @median = @sorted_numbers[(@count/2).to_i]

    end

    @sum = 0

    @numbers.each do |num|
      @sum = @sum + num
    end

    @mean = @sum / @count


    @sqdiff_mean_table = []
    @numbers.each do |num|
      @diff_of_mean = num - @mean
      @sqdiff_mean_table.push(@diff_of_mean**2)
    end

    @sq_sum_of_diffs = 0

    @sqdiff_mean_table.each do |sqdiffmean|
      @sq_sum_of_diffs = @sq_sum_of_diffs + sqdiffmean
    end

    @variance = @sq_sum_of_diffs / @count

    @standard_deviation = @variance ** 0.5


  @most_present_number_count = 0

  @sorted_numbers.each do |snum|
    if @sorted_numbers.count(snum) > @most_present_number_count

      @most_present_number_count = @sorted_numbers.count(snum)
      @most_present_number = snum
    end
  end

    @mode = @most_present_number

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
