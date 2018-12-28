class Api::TransactionsController < ApplicationController
  def index
    transactions = Transaction.all
    json = TransactionSerializer.render(transactions)
    render json: json
  end
end
