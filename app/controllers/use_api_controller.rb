class UseApiController < ApplicationController
  def home
    
  end

  def test
    @response = HTTParty.get(SLACK[:api_url] + '/auth.test', query: {
      token: session[:access_token]
    })
  end

  def list_emojis
    @response = HTTParty.get(SLACK[:api_url] + '/emoji.list', query: {
      token: session[:access_token]
    })
  end

  def see_emojis
    response = HTTParty.get(SLACK[:api_url] + '/emoji.list', query: {
      token: session[:access_token]
    })
    @emoji_list_hash = response.parsed_response["emoji"]
  end

  def list_channels
    response = HTTParty.get(SLACK[:api_url] + '/channels.list', query: {
      token: session[:access_token]
    })
    parsed_response = response.parsed_response
    @filtered_response = parsed_response["channels"].select do |channel| 
      channel["is_member"] && channel["name"] =~ /orl/ 
    end
  end

  def new_message
  end

  def message
    response = HTTParty.post(SLACK[:api_url] + '/chat.postMessage', query: {
      token: session[:access_token],
      channel: "C04U2G8SM",
      text: params[:text],
      username: 'RailsBot',
      icon_url: 'https://pbs.twimg.com/profile_images/2990302215/ec3b56612e3b626d077089f2cee6d3dc_normal.png'
    })
    #don't check anything
    redirect_to root_url, notice: "Your message has been sent!"
  end 

end
