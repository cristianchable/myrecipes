require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: 'Cristian', email: 'cristian.chable@hotmail.com')
  end

  test "should be valid" do
    assert @chef.valid?
  end

  test "name should be present" do
    @chef.chefname = ''
    assert_not @chef.valid?
  end

  test "name should be less than 30 characteres" do
   @chef.chefname = "a" * 31
   assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end

  test "email should not be too long" do
    @chef.email = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should accept correct format" do
    valid_emails = %w[user@example.com cristian.chable@hotmail.com]
    valid_emails.each do |email_valid|
      @chef.email = email_valid
      assert @chef.valid?, "#{email_valid.inspect} should be valid"
    end
  end
  
  test "email should not accept incorrect format" do
    invalid_emails = %w[adfadfa ajshdf@jiasfj@example]
    invalid_emails.each do |invalid_email|
      @chef.email = invalid_email
      assert_not @chef.valid?
    end
  end

  test "email should be unique" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be lower case before save in the db" do
    mixed_email = "John@Example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
end
