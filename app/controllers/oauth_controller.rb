class OauthController < ApplicationController

  def authorize
    session[:state] = masked_authenticity_token(session).gsub(/\+/,' ')
    redirect_to "#{SLACK[:authorize_uri]}?client_id=#{SLACK[:client_id]}&
    redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Foauth%2Frequest_access_token&
    scope=#{SLACK[:scope]}&state=#{session[:state]}&team=#{SLACK[:team]}"
  end

  def request_access_token
    if session[:state] == params[:state]
      response = HTTParty.get(SLACK[:api_url] + SLACK[:request_token_uri], query: {
        client_id:     SLACK[:client_id],
        client_secret: SLACK[:client_secret],
        code:          params[:code],
        redirect_uri:  'http://localhost:3000/oauth/request_access_token'
      })
      session[:access_token] = response.parsed_response["access_token"]
      redirect_to root_url, notice: "You can now post to Slack from this app"
    else
      redirect_to root_url, notice: "There was a problem requesting an access token; 
      params[:state] was #{params[:state]} and session[:state] is #{session[:state]}"
    end
  end

  def logout
    session[:access_token] = nil
    redirect_to root_url, notice: "You have logged out"
  end
end