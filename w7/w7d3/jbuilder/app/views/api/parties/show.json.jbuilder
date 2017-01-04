json.extract! @party, :name, :location
json.set! :guests do
  json.array! @party.invitations do |invitation|

    json.partial! 'api/guests/guest', guest: invitation.guest
    json.set! :gifts do
      json.array! invitation.guest.gifts do |gift|
        json.extract! gift, :title, :description
      end
    end
  end
end
