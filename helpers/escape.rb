helpers do
  def escape(text)
    Rack::Utils.escape_html(text)
  end

  alias_method :h, :escape
end
