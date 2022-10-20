require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: 'cristian', email: 'cristian.chable@hotmail.com')
    @recipe = Recipe.create(name: 'vegetable soute', description: 'great vegetable soutee, add vegetable and oil', chef: @chef)
    @recipe2 = @chef.recipes.build(name: 'chicken soute', description: 'great chicken dish')
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
