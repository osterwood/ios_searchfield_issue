class SelectScreen < PM::Screen
  title ""

  attr_accessor :searchable

  def on_load
    @layout = TableLayout.new(root: self.view, nav_bar: true)
    @layout.form_view = form.view
    @layout.build
  end

  def form
    @form_screen ||= begin
      s = SelectTable.new
      self.addChildViewController s
      s.parent_screen = self
      s
    end
  end

  def select(args={})
    key  = self.title.downcase.to_sym
    data = {key: key, value: args[:label]}

    close(data)
  end

end


class SelectTable < PM::TableScreen

  def models
    [
      "Test 1",
      "Test 2",
      "Test 3",
      "Test 4",
      "Test 5",
      "Test 6",
      "Test 7",
      "Test 8"
    ]
  end

  def will_appear
    if self.parent_screen.searchable
      # TODO : figure out why frame here doesn't shift the Search field down any
      # and why the search bar is being covered up by the iOS 7 nav bar.
      # frame = CGRectMake(0, 100, 320, 44)
      # self.make_searchable(frame: frame, content_controller: self, search_bar: {placeholder: "Test Search"})

      self.make_searchable(content_controller: self, search_bar: {placeholder: "Test Search"})
    end
  end

  def table_data
    rows = models.map do |entry|
      {
        title: entry,
        action: :select,
        editing_style: :delete,
        arguments: { 
          label: entry
        }
      }
    end

    [{
      cells: rows
    }]
  end

  def on_cell_deleted(cell)
    PM.logger.info "Deleting #{cell}"
  end

  def select(args={})
    self.parent_screen.select(args)
  end

end
