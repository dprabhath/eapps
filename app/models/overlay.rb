class Overlay
  def self.images
    %w(100th.png ideabash.png hat001.png fb002.png sliitwalk.png icnew.png fb11.png NRnight.png 45.png 46.png 47.png 48.png cheer.png dashain.png dashain2.png npflag.png dharahara.png eastern.png eastern2.png merodesh.png FF-01.png FF-02.png ilovenepal.png imaginecupnew.png 001.png 002.png 003.png IMUOR.png o1.png o2.png o3.png final.png a01.png a02.png a03.png a04.png a05.png a06.png SLIATE.png IT.png )
  end

  def self.create_image source, overlay_image, user
    source = source.resize_to_fill(500, 500)
    file = "#{user.uid}_#{overlay_image}"

    overlay = Magick::Image.read("app/assets/images/overlays/#{overlay_image}").first
    temp = source.composite(overlay, Magick::CenterGravity, Magick::SrcOverCompositeOp)
    temp.opacity = (Magick::TransparentOpacity-Magick::OpaqueOpacity) * 0.01
    source.composite!(temp, Magick::CenterGravity, Magick::SrcOverCompositeOp)
    s3_upload source, file
  end

  def self.get_source_image user
    source = Magick::ImageList.new
    image_url = URI.parse(user[:image_url])
    image_url.scheme = 'https'
    urlimage = open(image_url)
    source.from_blob(urlimage.read).first
  end

  def self.s3_upload source, file
    s3 = Aws::S3::Resource.new(
            region:'us-west-2',
            credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'],
                                          ENV['AWS_SECRET_ACCESS_KEY']))
    bucket = s3.bucket(ENV['S3_BUCKET_NAME'])
    bucket.object(file).put({body: source.to_blob, acl: 'public-read'})
  end
end
