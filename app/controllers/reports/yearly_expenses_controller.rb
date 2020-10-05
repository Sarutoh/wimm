# frozen_string_literal: true

module Reports
  class YearlyExpensesController < BaseController
    helper_method :start_period, :end_period

    def show; end

    private

    def start_period
      @start_period ||= params.fetch(:from, Date.today.at_beginning_of_month).to_date
    end

    def end_period
      @end_period ||= params.fetch(:to, Date.today).to_date
    end
  end
end
