module API
  class Root < Grape::API
    content_type :json, 'application/json'
    default_format :json
    rescue_from :all
    
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
              :loginEndpoint => { :url => 'http://localhost:3000/oauth/authorize' },
              :tokenName => 'access_token',
            }
          }
        }
      }
  end
end
