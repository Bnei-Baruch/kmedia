module Sunspot
  module Search
    class StandardSearch

        def current_page
          @query.page
        end

        def num_pages
          (total / limit_value).ceil
        end

        def limit_value
          @query.per_page
        end
        alias_method :per_page, :limit_value

        private

      def maybe_will_paginate(collection)
        collection.instance_eval <<-RUBY, __FILE__, __LINE__ + 1
          def current_page
            #{@query.page}
          end

          def num_pages
            (#{total} / limit_value).ceil
          end

          def limit_value
            #{@query.per_page}
          end
        RUBY
        collection
      end
    end
  end
end