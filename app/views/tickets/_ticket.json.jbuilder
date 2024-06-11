json.extract! ticket, :id, :summary, :priority, :status, :reported, :collection, :link, :user_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
