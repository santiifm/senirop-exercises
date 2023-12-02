class Exercise1
  num_array = []

  # Fill an array with numbers between 1 and 100
  for n in 1..100
    num_array << n
  end

  # For each number in the array check if multiple of 3 and/or 5 and return corresponding string or n°
  num_array.each do |n|
    result =
      if n % 3 == 0 && n % 5 == 0
        'Senir Op'
      elsif n % 3 == 0
        'Senir'
      elsif n % 5 == 0
        'Op'
      else
        n
      end

    puts result
  end
end
