json.extract! item, :id, :name, :category, :details, :created_at, :updated_at
json.url item_url(item, format: :json)
