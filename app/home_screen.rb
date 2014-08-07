class HomeScreen < PM::Screen
  title "Home"

  def on_load
    @layout = TableLayout.new(root: self.view, nav_bar: true)
    @layout.form_view = form.view
    @layout.build
  end

  def form
    @form_screen ||= begin
      s = HomeTable.new
      self.addChildViewController s
      s.parent_screen = self 
      s
    end
  end

end


class HomeTable < PM::TableScreen
  
  def categories
    [
      {label: "Category 1",  key: :one, searchable: true},
      {label: "Category 2",  key: :two},
      {label: "Category 3",  key: :three, searchable: true},
      {label: "Category 4",  key: :four}
    ]
  end

  def table_data
    rows = categories.map do |field|
      {
        title: field[:label],
        action: :select,
        arguments: field
      }
    end

    [{
      cells: rows
    }]
  end

  def select(args={})
    open SelectScreen.new({
      title: args[:label],
      searchable: args[:searchable]
    })
  end

  def on_return(args={})
    PM.logger.info "return : #{args}"
  end
end


