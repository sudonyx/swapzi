class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @items = Item.all

    @items = policy_scope(Item)
  end
end
