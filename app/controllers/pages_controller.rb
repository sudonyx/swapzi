class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @swaps = Swap.all.order(created_at: :desc).limit(4)
  end
end
