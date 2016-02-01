Rails.application.config.middleware.use OmniAuth::Builder do
  app_id = ENV['app_id']
   secret = ENV['secret']
	
	
	
	

    provider :facebook, '770027773143418', '22464fb63efa613db51a00f6fac2bc71', scope: 'publish_actions',
                :image_size => {width: 500, height: 500}
end
