require 'wlang'
require 'wlang/dummy'
module WLang
  class Html < WLang::Dialect

    module Helpers

      def value_of(fn)
        evaluate(render(fn).to_s.strip)
      end
      private :value_of
      
      def to_html(val)
        val = val.to_html if val.respond_to?(:to_html)
        val.to_s
      end
      private :to_html
      
      def escape_html(val)
        Temple::Utils.escape_html(val)
      end
      private :escape_html

    end
    include Helpers

    module HighOrderFunctions

      def bang(buf, fn)
        buf << value_of(fn).to_s
      end

      def plus(buf, fn)
        case val = value_of(fn)
        when Proc
          render(to_html(val.call), nil, buf)
        when Template
          render(val, nil, buf)
        else
          render(to_html(val), nil, buf)
        end
      end

      def dollar(buf, fn)
        buf << escape_html(plus("", fn)) 
      end
      
      def ampersand(buf, fn)
        buf << escape_html(render(fn))
      end

    end
    include HighOrderFunctions

    tag '!', :bang
    tag '+', :plus
    tag '$', :dollar
    tag '&', :ampersand

  end # class Html
end # module WLang
