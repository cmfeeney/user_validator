require 'minitest/pride'
require 'minitest/autorun'
require './user_validator.rb'

class UserValidatorTest < Minitest::Test
  def test_initialize
    assert UserValidator.new('homework.csv')
  end

  def test_validate_email
    a = UserValidator.new('homework.csv')
    assert a.validate_email(a.data[0][3])
    refute a.validate_email(a.data[1][3])
  end

  def test_validate_date
    a = UserValidator.new('homework.csv')
    assert a.validate_date(a.data[0][1])
    refute a.validate_date(a.data[1][1])
  end

  def test_validate_phone
    a = UserValidator.new('homework.csv')
    assert a.validate_phone(a.data[0][4])
    refute a.validate_phone(a.data[4][4])
  end

  def test_validate
    a = UserValidator.new('sample.csv')
    assert_equal [[3, "Not a valid email address"]], a.validate
  end
end
