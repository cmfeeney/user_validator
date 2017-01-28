require 'minitest/pride'
require 'minitest/autorun'
require './user_validator.rb'

class UserValidatorTest < Minitest::Test
  def test_initialize
    assert UserValidator.new('homework.csv')
  end

  def test_validate_email
    a = UserValidator.new('homework.csv')
    assert a.validate_email(a.data[0]["email"])
    refute a.validate_email(a.data[1]["email"])
  end

  def test_validate_date
    a = UserValidator.new('homework.csv')
    assert a.validate_date(a.data[0]["joined"])
    refute a.validate_date(a.data[1]["joined"])
  end

  def test_validate_phone
    a = UserValidator.new('homework.csv')
    assert a.validate_phone(a.data[0]["phone"])
    refute a.validate_phone(a.data[4]["phone"])
  end

  def test_validate_password
    a = UserValidator.new('homework.csv')
    assert a.validate_password(a.data[4]["password"])
    refute a.validate_password(a.data[0]["password"])
  end

  def test_validate
    a = UserValidator.new('sample.csv')
    assert_equal [[3, "Not a valid email address", "Not a valid password"]], a.validate
  end
end
