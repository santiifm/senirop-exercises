class BycicleLock
  DIAL_NUMBERS = 10
  def makeDistinct(dials)
    # Turn int into array and map again array to ints
    dials = dials.to_s.split('')
    dials = dials.map(&:to_i)
    purged_dials = Hash.new(0)
    @operations = ""

    # As numbers of the dial are only from 0 to 9 return if more than 10 dials
    return if dials.length > 10

    generate_operations(dials)

    puts @operations
  end

  private

  # Gets the minimum distance between 2 dial numbers
  def circular_distance(number1, number2)
    clockwise_distance = (number2 - number1 + DIAL_NUMBERS) % DIAL_NUMBERS
    counterclockwise_distance = (number1 - number2 + DIAL_NUMBERS) % DIAL_NUMBERS

    [clockwise_distance, counterclockwise_distance].min_by { |num| num.abs }
  end

  # Rotates the dial and/or passes to the next one
  def rotate_dial(distance)
    if distance.include?(0)
      distance = distance.min_by { |num| num.abs }
      if distance.positive?
        @operations << "+"
        @operations << "<"
        "+"
      else
        @operations << "-"
        "-"
      end
    else
      @operations << "<"
    end
  end

  # Goes through each dial, gets the distance with other dials and rotates
  def generate_operations(dials)
    dials.each_with_index do |number, dial|
      done = false
      
      while done == false
        distance = []
        dials_copy = dials.dup
        dials_copy.delete_at(dial)

        dials_copy.each do |other_number|
          distance << circular_distance(dials[dial], other_number)
        end

        rotation = rotate_dial(distance)

        if rotation == "+"
          dials[dial] += 1
        elsif rotation == "-"
          dials[dial] -= 1
        else
          done = true
        end
      end
    end
  end
end

if ARGV.length > 0
  make_distinct = BycicleLock.new
  make_distinct.makeDistinct(ARGV[0])
end
