module API
  class Root < Grape::API
    content_type :json, 'application/json'
    default_format :json
    
    # Workaround for `error!` being unavailable in rescue_from blocks right now:
    # https://github.com/intridea/grape/commit/c20a9ad3ff81865898258d8bf92271048f1ff2b0
    def self.http_error(code, e)
      Rack::Response.new([ JSON.pretty_generate({ error: e }) ], code, { "Content-type" => "text/json" }).finish
    end
    
    rescue_from :all
    rescue_from WineBouncer::Errors::OAuthUnauthorizedError do |e|
      API::Root::http_error 401, "OAuth authorization is required here"
    end
    rescue_from WineBouncer::Errors::OAuthForbiddenError do |e|
      API::Root::http_error 403, "Your access token is invalid for this scope"
    end
    rescue_from CanCan::AccessDenied do |e|
      API::Root::http_error 403, "Can't let you do that!"
    end
    
    use ::WineBouncer::OAuth2
    mount API::V1::Root
    
    add_swagger_documentation \
      :api_version => 'v1',
      :base_path => '/api',
      :hide_documentation_path => true,
      :models => [
        API::Entities::Character,
      ],
      :authorizations => {
        :oauth2 => {
          :type => 'oauth2',
          :scopes => [
            { :scope => 'public', :description => "Public Access" },
          ],
          :grantTypes => {
            :implicit => {
              :loginEndpoint => { :url => '/oauth/authorize' },
              :tokenName => 'access_token',
            }
          }
        }
      }
  end
end
