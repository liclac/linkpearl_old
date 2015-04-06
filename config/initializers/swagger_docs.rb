Swagger::Docs::Config.register_apis({
  "v1" => {
    :api_extension_type => :json,
    :api_file_path => "public/api/v1/",
    :base_path => ("http://localhost:3000" if Rails.env.development? else '') + "/api/v1",
    :clean_directory => false,
    :attributes => {
      :info => {
        "title" => "API Documentation",
      }
    }
  }
})
