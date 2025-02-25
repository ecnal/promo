class Api::V1::AnalyticsController < ApplicationController
  def index
    top_5_carts = Analytic.select("source, source_id, COUNT(source_id)")
                          .where("source ILIKE 'carts%'")
                          .where("analytics.created_at::date = ?", Date.today)
                          .group("source, source_id")
                          .order("COUNT(source_id) DESC")
                          .limit(5)
    top_5_items = Analytic.select("source, source_id, items.name, COUNT(source_id)")
                          .joins("INNER JOIN items ON items.id = analytics.source_id")
                          .where("source ILIKE 'items%'")
                          .where("analytics.created_at::date = ?", Date.today)
                          .group("source, source_id, items.name")
                          .order("COUNT(source_id) DESC")
                          .limit(5)
    render json: { top_5_carts: top_5_carts, top_5_items: top_5_items }.to_json, status: :ok
  end
end
