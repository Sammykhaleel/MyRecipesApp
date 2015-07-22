require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Sammy", email: "sammy@gmail.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chef should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end

  test "email should be preset" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should not be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
  end

  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email validation should accept valid address" do
    valid_address = %w[user1@sample.com user2@example.org user_3@gmail.com user-4@yahoo.org]
    valid_address.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email validation should reject invaild address" do
    invalid_address = %w[example.com example@gmail @yahoo.com user_.org]
    invalid_address.each do |i|
      @chef.email = i
      assert_not @chef.valid? "#{i.inspect} should invalid"
    end
  end
end