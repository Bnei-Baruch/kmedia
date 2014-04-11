# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderSortableTreeHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]

        "
          <li data-node-id='#{ node.id }' id='#{ node.id }_#{ options[:klass] }'>
            <div class='item #{node.visible ? '' : 'in'}visible-node #{node.open ? 'status-open' : 'status-closed'}'>
              <i class='#{options[:boost][node.id.to_s].blank? ? 'tree-zipper' : 'tree-zipper plus'}'></i>
              <i class='handle'></i>
              #{ show_link }
              #{ controls }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url  = h.url_for(ns + [node])
        title_field = options[:title]

        "<h4>#{ h.link_to(node.send(title_field), url) }</h4>"
      end

      def controls
        node = options[:node]

        move_prepare_path = h.url_for(:controller => options[:klass].pluralize, :action => :move_prepare, :id => node)
        edit_path = h.url_for(:controller => options[:klass].pluralize, :action => :edit, :id => node)
        show_path = h.url_for(:controller => options[:klass].pluralize, :action => :show, :id => node)

        "
          <div class='controls'>
            #{ h.link_to '', move_prepare_path, :class => :move }
            #{ h.check_box_tag 'source', node.id, false, :class => :select }
            #{ h.link_to '', edit_path, :class => :edit }
            #{ h.link_to '', show_path, :class => :delete, :method => :delete, :data => { :confirm => 'Are you sure?' } }
          </div>
        "
      end

      def children
        unless options[:children].blank?
          "<ol class='nested_set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end
