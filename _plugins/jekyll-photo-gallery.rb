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
                                   <img alt="'+curr["title"]+'" itemprop="thumbnailUrl" src="/assets/images/posts/'+curr["img"]+'.jpg"/>
                                   <meta itemprop="name" content="'+curr["title"]+'" />
                                 </a>
                               </div>'
          end
        }
      end
      @result = @result + '</div>'

      #If you want to configure each album gallery individually you can remove this script
      #and add it in the template/post directly.
      @result = @result + '<script>
                              window.onload=function(){
                                  $("#gallery").justifiedGallery({
                                      rowHeight : 220,
                                      maxRowHeight: 340,
                                      margins : 5,
                                      border : 0,
                                      fixedHeight: false,
                                      lastRow : \'nojustify\',
                                      captions: true
                                  });
                                  $("#gallery").fadeIn(500);
                              }
                          </script>'
    end

    def render(context)
      "#{@result}"
    end
  end
end
Liquid::Template.register_tag('includeGallery', Jekyll::IncludeGalleryTag)
