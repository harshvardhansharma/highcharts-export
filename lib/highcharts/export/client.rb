module Highcharts
  module Export
    class Client

      BASE_URL = 'http://export.highcharts.com'.freeze

      def initialize(data)
        @data = data
        @width = 400
      end

      def scale=(scale)
        if scale.present?
          @scale = scale.to_i
        end
      end

      def width=(width)
        if width.present?
          raise ParamsException if width.to_i > 2000
          @width = width.to_i
        end
      end

      def resources=(resources)
        if resources.present?
          JSON.parse(resources)
          @resources = resources
        end
      end

      def jpg
        @image_type = 'image/jpeg'
        render
      end

      def png
        @image_type = 'image/png'
        render
      end

      def pdf
        @image_type = 'application/pdf'
        render
      end

      def render
        HTTParty.post(BASE_URL, headers: headers, body: body)
      end

      def headers
        {
          'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8'
        }
      end

      def body
        res = []
        res << 'async=true'
        res << "type=#{@image_type}"
        res << "width=#{@width}"
        res << "options=#{@data}"
        res.join('&')
      end

    end
  end
end
