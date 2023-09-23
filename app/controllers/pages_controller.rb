class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @swaps = Swap.where(completed: true).order(created_at: :desc).limit(5)
  end
end
