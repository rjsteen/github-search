class SearchesController < ApplicationController

  before_action :set_client, only: [:log_in, :index]
  before_action :log_in, :unless => :got_token?, only: [:index]

  def log_in
    #github oauth
    redirect_to @github.authorize_url
  end

  def index

    unless session[:token_github].present?
      authorization_code = params[:code]
      access_token = @github.get_token authorization_code
      session[:token_github] = access_token.token
    end    

    respond_to do |format|
      format.html
      format.json { render json: GithubDatatable.new(view_context, session[:token_github])}
    end

  end

  def got_token?
    session[:token_github].present? || params[:code].present?
  end

  def set_client
    @github = Github.new client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET']
  end

end