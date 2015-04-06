class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    "/api/docs/#{api_version}/#{path}"
  end
end

Swagger::Docs::Config.register_apis({
  "v1" => {
    :api_extension_type => :json,
    :api_file_path => "public/api/docs/v1/",
    :base_path => (Rails.env.development? ? "http://localhost:3000" : "http://linkpearl.net"),
    :clean_directory => true,
    :attributes => {
      :info => {
        "title" => "API Documentation",
      }
    }
  }
})
