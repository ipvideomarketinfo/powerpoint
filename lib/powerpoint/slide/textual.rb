module Powerpoint
  module Slide
    class Textual
      include Powerpoint::Util
      
      attr_reader :options

      def initialize(arguments={})
        require_arguments [:title, :content], arguments
        arguments.each {|k, v| instance_variable_set("@#{k}", v)}
      end

      def save(index)
        save_rel_xml(index)
        save_slide_xml(index)
      end

      def title
        escape_xml(@title)
      end

      def content
        @content.map {|c| escape_xml(c)}
      end

      def font_scale
        if options[:fontScale]
          ((options[:fontScale] * 0.01) * 90000).to_i
        end
      end

      private

      def save_rel_xml index
        File.open("#{extract_path}/ppt/slides/_rels/slide#{index}.xml.rels", 'w'){ |f| f << render_view('textual_rel.xml.erb') }
      end

      def save_slide_xml index
        File.open("#{extract_path}/ppt/slides/slide#{index}.xml", 'w'){ |f| f << render_view('textual_slide.xml.erb') }
      end
    end
  end
end