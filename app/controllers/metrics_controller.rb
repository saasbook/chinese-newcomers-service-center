class MetricsController < ApplicationController
  def index
  	tuple = Item.metrics
  	@metrics = tuple[0]
  	@warning_string = tuple[1]
  end
end
