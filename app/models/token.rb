require 'net/http'
require 'json'

class Token < ActiveRecord::Base

  def to_params
    {'refresh_token' => refresh_token,
     'client_id' => "907497187323-4svde7p9q09s8tqvo6qj14c02jtr03r6.apps.googleusercontent.com",
     'client_secret' => "yzjuDIehwLebdZYEETQj7Y4h",
     'grant_type' => 'refresh_token'}
  end

  def request_token_from_google
    url = URI("https://accounts.google.com/o/oauth2/token")
    Net::HTTP.post_form(url, self.to_params)
  end

  def refresh!
    response = request_token_from_google
    data = JSON.parse(response.body)
    update_attributes(
        access_token: data['access_token'],
        expires_at: Time.now + (data['expires_in'].to_i).seconds)
  end

  def expired?
    expires_at < Time.now
  end

  def fresh_token
    refresh! if expired?
    access_token
  end

end
