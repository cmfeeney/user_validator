require 'csv'

class UserValidator
  attr_reader :data
  def initialize(filename)
    @data = []
    CSV.foreach(filename, headers: true) do |row|
      @data << row.to_hash
    end
    @invalid_lines = []
  end

  def validate
    #Counter starts at two because that's the first row number with data
    counter = 2
    valid_count = 0
    data.each do |x|
      #create array with row number
      checker = [counter]
      #check each field and add message to array if not valid
      if validate_date(x["joined"].to_s) == nil
        checker << "Not a valid date"
      end
      if validate_email(x["email"].to_s) == nil
        checker << "Not a valid email address"
      end
      if validate_phone(x["phone"].to_s) == nil
        checker << "Not a valid phone number"
      end
      if validate_password(x["password"].to_s) == nil
        checker << "Not a valid password"
      end
      counter += 1
      #if array has more than elements than just row number in it (i.e. error msgs were added), add it to invalid_lines array
      if checker.count > 1
        @invalid_lines << checker
      end
    end
    #counter subtracts 2 since that's what we started it at
    valid_count = counter - 2 - @invalid_lines.count
    puts "There were #{valid_count} valid lines in the CSV."
    if @invalid_lines.count >= 1
    puts "The invalid row numbers with their invalid fields are listed below:"
    #use inspect to put each element on its own row
    @invalid_lines.each{|e| puts e.inspect}
    end
  end

  def validate_date(value)
    value.match(/^\d{1,4}[\/\-]\d+[\/\-]\d{2,4}$/)
  end

  def validate_email(value)
    value.match(/^.[^@]+@\w[^@]+\.(com|org|net|edu|gov|mil)$/)
  end

  def validate_phone(value)
    value.match(/^(\(\d{3}\)|\d{3})(-|\.|\s|)\d{3}(-|\.|\s|)\d{4}$/)
  end

  def validate_password(value)
    count = 0
    #password contains a symbol
    if value.match(/(\!|\@|\#|\$|\%|\^|\&|\*)/)
      count += 1
    end
    #password contains a lowercase letter
    if value.match(/[a-z]+/)
      count += 1
    end
    #password contains an uppercase letter
    if value.match(/[A-Z]+/)
      count += 1
    end
    #password contains a number
    if value.match(/\d+/)
      count += 1
    end
    #password has at least six characters and at least three of the above
    if value.match(/^.{6,}$/) && count >= 3
      return true
    end
  end
end

file = UserValidator.new('homework.csv')
file.validate
