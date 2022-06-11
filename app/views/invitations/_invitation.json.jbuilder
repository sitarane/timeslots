json.extract! invitation, :id, :sender_id, :recipient_id, :calendar_id, :token, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
