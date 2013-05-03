module ActsAsTree
  module InstanceMethods
    def all_children
      self.children.inject([]) do |res, category|
        res << category
        root_children = category.all_children.flatten
        res << root_children unless root_children.empty?
        res
      end.flatten
    end

    def all_children_with_root
      all_children.unshift(self)
    end
  end
end
