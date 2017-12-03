class MetricsController < ApplicationController
  def index
  	@metrics = Item.metrics
  end
end
