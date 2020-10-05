# frozen_string_literal: true

class CategoriesController < BaseController
  def index
    @categories = Category.where(user: current_user)
    @expense_categories = ExpenseCategory.where(user: current_user).exclude_transfer
    @income_categories = IncomeCategory.where(user: current_user).exclude_transfer
  end

  def new
    @category = current_user.categories.build
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category has been created'
    else
      flash.now[:error] = 'Category not created'
      render :new
    end
  end

  def update
    @category = current_user.categories.find(params[:id])

    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category has been updated'
    else
      flash.now[:error] = 'Category not updated'
      render :edit
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])

    return unless RemoveCategoryPolicy.new(@category).allowed?

    @category.destroy
    redirect_to categories_path, notice: 'Category has been deleted'
  end

  private

  def category_params
    params.require(:category).permit(:name, :type)
  end
end
