class QuotesController < Rulers::Controller
  def exception
    raise "Trouble maker!"
  end

  def a_quote
    @verb = "run"
    @noun = "kangie"
    render :a_quote
  end
end
