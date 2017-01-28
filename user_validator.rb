require 'csv'

class UserValidator
  attr_reader :data
  def initialize(filename)
    @data = CSV.read(filename)
    @data = @data[1..-1]
    @invalid_lines = []
  end

  def validate
    counter = 2
    valid_count = 0
    data.each do |x|
      checker = [counter]
      if validate_date(x[1].to_s) == nil
        checker << "Not a valid date"
      end
      if validate_email(x[3].to_s) == nil
        checker << "Not a valid email address"
      end
      if validate_phone(x[4].to_s) == nil
        checker << "Not a valid phone number"
      end
      counter += 1
      if checker.count > 1
        @invalid_lines << checker
      end
    end
    valid_count = counter - 2 - @invalid_lines.count
    puts "There were #{valid_count} valid lines in the CSV."
    if @invalid_lines.count >= 1
    puts "The invalid rows with their invalid fields are listed below:"
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
end

file = UserValidator.new('homework.csv')
file.validate
