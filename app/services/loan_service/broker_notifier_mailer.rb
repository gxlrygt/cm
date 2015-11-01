# Notifiers brokers that a loan has been submitted
class LoanService::BrokerNotifierMailer

  def initialize(loan_id)
    @loan_id = loan_id
  end

  def perform
    loan = Loan.find(@loan_id)

    LoansMailer.notify_brokers(loan).deliver
  end

end