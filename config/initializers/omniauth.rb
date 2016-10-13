Rails.application.config.middleware.use OmniAuth::Builder do
  app_id = ENV['app_id']
   secret = ENV['secret']
	
	
	
	

    provider :facebook, '931427906945547', '476720ad69544b3a5df495479f4c6f21', scope: 'publish_actions',
                :image_size => {width: 500, height: 500}
end
