class QuotesController < Rulers::Controller
  def new_quote
    attrs = {
      "submitter" => "web user",
      "quote" => "A picture is worth a thousand pixels",
      "attribution" => "Me"
    }
    m = FileModel.create attrs
    render :quote, :obj => m
  end

  def update_quote
    update_quote = Rulers::Model::FileModel.post(1)
    render :quote, :obj => update_quote
  end

  def exception
    raise "Trouble maker!"
  end

  def a_quote
    @verb = "run"
    @noun = "kangie"
    render :a_quote
  end

  def index
    quotes = FileModel.all
    render :index, :quotes => quotes
  end

  def quote_1
    quote_1 = Rulers::Model::FileModel.find(1)
    render :quote, :obj => quote_1
  end

  def show
    quote = FileModel.find(params["id"])
    render :quote, :obj => quote
  end
end
