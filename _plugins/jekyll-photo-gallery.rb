module Jekyll
  class IncludeGalleryTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @result = '<div id="gallery" style="margin-bottom: 20px;">'
      photos = YAML::load_file('_data/photos.yml')
      photos.each do |photo, details|
        [nil, *details, nil].each_cons(3){|prev, curr, nxt|
          if(curr["album"] == text.strip)
            @result = @result+'<div itemscope itemtype="http://schema.org/Photograph">
                                 <a itemprop="image" class="swipebox" title="'+curr["title"]+'">
                                   <img class="gallery-image" alt="'+curr["title"]+'" itemprop="thumbnailUrl" src="/assets/images/posts/'+curr["img"]+'.jpg"/>
                                   <meta itemprop="name" content="'+curr["title"]+'" />
                                 </a>
                               </div>'
          end
        }
      end
      @result = @result + '</div>'
      @result = @result + '<div id="myModal" class="modal">
                            <span class="close">&times;</span>

                            <!-- Modal Content (The Image) -->
                              <img class="modal-content" id="img01">

                              <!-- Modal Caption (Image Text) -->
                              <div id="caption"></div>

                           </div>'

    end

    def render(context)
      "#{@result}"
    end
  end
end
Liquid::Template.register_tag('includeGallery', Jekyll::IncludeGalleryTag)
