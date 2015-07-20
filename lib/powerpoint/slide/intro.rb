module Powerpoint
  module Slide
    class Intro
      include Powerpoint::Util

      def initialize(arguments={})
        require_arguments [:title, :subtitile], arguments
        arguments.each {|k, v| instance_variable_set("@#{k}", v)}
      end

      def save(index)
        save_rel_xml(index)
        save_slide_xml(index)
      end

      [:title, :subtitile].each do |attribute|
        define_method(attribute) do
          escape_xml instance_variable_get("@#{attribute}")
        end
      end

      private

      def save_rel_xml index
        File.open("#{extract_path}/ppt/slides/_rels/slide#{index}.xml.rels", 'w'){ |f| f << render_view('textual_rel.xml.erb') }
      end

      def save_slide_xml index
        File.open("#{extract_path}/ppt/slides/slide#{index}.xml", 'w'){ |f| f << render_view('intro_slide.xml.erb') }
      end
    end
  end
end