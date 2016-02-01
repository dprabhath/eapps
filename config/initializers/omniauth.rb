Rails.application.config.middleware.use OmniAuth::Builder do
  app_id = ENV['app_id']
   secret = ENV['secret']
	
	
	
	

    provider :facebook, '895562953865919', 'a7f72b0ede9646a3046dd7d2e9f7c158', scope: 'publish_actions',
                :image_size => {width: 500, height: 500}
end
