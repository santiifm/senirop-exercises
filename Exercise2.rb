class NearPalindromesDiv1
  ALPHABET_SIZE = 26

  def solve(word)
    purged_word = sort_and_purge_word(word)
    pairs = generate_pairs(purged_word)
    operations = calculate_operations(pairs)

    puts operations
  end

  private

  # Method to Sort and Purge word of unnecesary letters
  def sort_and_purge_word(word)
    letter_count = Hash.new(0)
    # Sort the word by the circular distance in the alphabet
    sorted_word = word.downcase.chars.sort_by { |char| [circular_distance(char, 'a'), char] }.join

    # Fill the hash with the amount of each letter
    sorted_word.each_char { |char| letter_count[char] += 1 }

    # Purge the word of all characters repeated an even amount of times
    # and if odd but more than 1 char, only add 1 to string
    purged_word = sorted_word.chars.select { |char|
                    if letter_count[char].odd? && letter_count[char] >= 1
                      (letter_count[char] -= 1; true)
                    end }.join
    if purged_word.length.odd?
      purged_word.chop!
    end

    purged_word
  end

  # Generates closest letter pairs
  def generate_pairs(purged_word)
    pairs = purged_word.chars.each_slice(2).map(&:join)
  end

  # Calculate the distance between charactes be it forwards or backwards
  # meaning it will match Y closer to A than F
  def circular_distance(char1, char2)
    clockwise_distance = (char2.ord - char1.ord + ALPHABET_SIZE) % ALPHABET_SIZE
    counterclockwise_distance = (char1.ord - char2.ord + ALPHABET_SIZE) % ALPHABET_SIZE
    [clockwise_distance, counterclockwise_distance].min
  end

  # Goes through each pair and gets the amount of operations
  def calculate_operations(pairs)
    operations = 0

    # Take the odd_letters and get the shortest distance between them and the closest char
    pairs.each do |pair|
      operations += calculate_letter_distance(pair[0], pair[1])
    end
    return operations
  end

  # Calculates amount of characters letters the two letters of the pair
  def calculate_letter_distance(char1, char2)
    diff = circular_distance(char1, char2)
    [diff, (diff + ALPHABET_SIZE) % ALPHABET_SIZE, (diff - ALPHABET_SIZE) % ALPHABET_SIZE].min
  end
end

if ARGV.length > 0
  solve = NearPalindromesDiv1.new
  solve.solve(ARGV[0])
end
