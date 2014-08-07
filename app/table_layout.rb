class TableLayout < MotionKit::Layout
  view :form_view

  def layout
    root :main do
      add form_view, :form
    end
  end

  def form_style
    top    0
    left   0
    right  "100%"
    bottom "100%"
  end

end
