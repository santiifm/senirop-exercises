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

  # Rotates the dial and/or passes to the next one
  def rotate_dial(diff)
    if diff.zero?
      @operations << "<"
    elsif diff.positive?
      diff.abs.times do |d|
        @operations << "+"
      end
    else
      diff.abs.times do |d|
        @operations << "-"
      end
    end
  end

  # Gets the difference to the nearest unoccupied number
  def nearest_unoccupied_number_diff(dial, dials)
    return 0 unless dials.include?(dial)

    left, right = dial - 1, dial + 1
    dial_distance = DIAL_NUMBERS - 1

    loop do
      left = (left + DIAL_NUMBERS) % DIAL_NUMBERS  # Ensure left is within the valid range
      right = right % DIAL_NUMBERS  # Ensure right is within the valid range

      left_diff = (dial - left) % DIAL_NUMBERS
      right_diff = (right - dial) % DIAL_NUMBERS

      return -left_diff if !dials.include?(left) || left_diff < right_diff
      return right_diff if !dials.include?(right) || right_diff < left_diff

      left -= 1
      right += 1
    end
  end



  # Goes through each dial, gets the distance to the nearest different number and rotates it
  def generate_operations(dials)
    dials.each_with_index do |number, dial|
      done = false

      while done == false
        distance = []
        dials_copy = dials.dup

        num_diff = dials.count(dials[dial]) > 1 ? nearest_unoccupied_number_diff(number, dials) : 0

        rotate_dial(num_diff)

        !num_diff.zero? ? dials[dial] += num_diff : done = true
      end
    end
  end
end

if ARGV.length > 0
  make_distinct = BycicleLock.new
  make_distinct.makeDistinct(ARGV[0])
end
