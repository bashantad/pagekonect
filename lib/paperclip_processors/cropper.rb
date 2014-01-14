require "paperclip"
module Paperclip
  class Cropper < Thumbnail
    def transformation_command
      if crop_command
        crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ') # super.first.sub(/ -crop \S+/, '')
      else
        super
      end
    end

    def crop_command
      target = @attachment.instance
      if target.cropping?
        # puts " -crop '#{target.crop_w.to_i}x#{target.crop_h.to_i}+#{target.crop_x.to_i}+#{target.crop_y.to_i}!'"
        # " -crop '#{target.crop_w.to_i}x#{target.crop_h.to_i}+#{target.crop_x.to_i}+#{target.crop_y.to_i}!'"
        ["-crop", "#{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}!"]
      end
    end
  end
end