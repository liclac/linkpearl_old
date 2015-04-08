module API
  class Root < Grape::API
    content_type :json, 'application/json'
    default_format :json
    rescue_from :all
    
    mount API::V1::Root
    
    add_swagger_documentation :api_version => 'v1',
                              :base_path => '/api',
                              :hide_documentation_path => true,
                              :models => [
                                API::Entities::Character,
                              ]
  end
end
