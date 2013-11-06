class QuotesController < Rulers::Controller
  def exception
    raise "Trouble maker!"
  end

  def a_quote
    render :a_quote, :noun => :winking
  end
end
