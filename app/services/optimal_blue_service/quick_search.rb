# Performs a quick search through OB
class OptimalBlueService::QuickSearch

  def initialize(quick_pricer)
    @quick_pricer = quick_pricer
    @state = State.find(@quick_pricer.state_id)
  end

  def perform
    raw_xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">
    <soap:Header>
        <ServiceAccount xmlns=\"http://OptimalBlue.com/PricingServices\">
            <Username>#{ENV['OB_USERNAME']}</Username>
            <Password>#{ENV['OB_PASSWORD']}</Password>
        </ServiceAccount>
    </soap:Header>
    <soap:Body>
        <QuickSearch xmlns=\"http://OptimalBlue.com/PricingServices\">
            <xmlRequest>
                <Request xmlns=\"\">
                  <PricingRequestHeader>
                  <Action>GetQuote</Action>
                  <GUID>ba758266-a272-4c10-8c2d-a12269c51ff8</GUID>
                  </PricingRequestHeader>
                  <TransactionData>
                    <SingleInstanceData>
                      <AutomatedUnderwritingSystemName>#{@quick_pricer.auto_uw_system || ''}</AutomatedUnderwritingSystemName>
                      <BorrowerPaysRequiredMIIndicator>#{@quick_pricer.borrower_paid_mi}</BorrowerPaysRequiredMIIndicator>
                      <BorrowerTotalDebtExpenseRatioPercent>#{@quick_pricer.debt_to_income_pct || ''}</BorrowerTotalDebtExpenseRatioPercent>
                      <CombinedLTVRatioPercent>#{@quick_pricer.cltv || ''}</CombinedLTVRatioPercent>
                      <EscrowWaiverIndicator>#{@quick_pricer.waived_escrows}</EscrowWaiverIndicator>
                      <FinancedUnitCount>#{@quick_pricer.units || ''}</FinancedUnitCount>
                      <LoanAmount>#{@quick_pricer.loan_amount}</LoanAmount>
                      <LoanPurpose>#{@quick_pricer.loan_purpose}</LoanPurpose>
                      <LoanRepresentativeMortgageScoreValue>#{@quick_pricer.credit_score || ''}</LoanRepresentativeMortgageScoreValue>
                      <MIRequiredForLoan>#{@quick_pricer.mortgage_insurance ? 'True' : 'False'}</MIRequiredForLoan>
                      <PropertyCountyName>#{@quick_pricer.county_name}</PropertyCountyName>
                      <PropertyCountyFIPS>#{@quick_pricer.county_fips}</PropertyCountyFIPS>
                      <PropertyStateName>#{@state.name} (#{@state.code})</PropertyStateName>
                      <PropertyType>#{@quick_pricer.property_type}</PropertyType>
                      <PropertyUsageType>#{@quick_pricer.property_use}</PropertyUsageType>
                      <PropertyValuationAmount>#{@quick_pricer.appraisal_amount}</PropertyValuationAmount>
                      <RefinanceCashOutAmount>#{@quick_pricer.cash_out_amount}</RefinanceCashOutAmount>
                      <StoriesCount>#{@quick_pricer.stories}</StoriesCount>
                    </SingleInstanceData>
                    <MultiInstanceData>"
    if @quick_pricer.product_type && @quick_pricer.product_type.any?
      @quick_pricer.product_type.each do |pt|
        raw_xml << "  <DesiredLoanType>#{pt}</DesiredLoanType>"
      end
    end
    if @quick_pricer.amortization_type && @quick_pricer.amortization_type.any?
      @quick_pricer.amortization_type.each do |at|
        raw_xml << "  <DesiredAmortizationType>#{at}</DesiredAmortizationType>"
      end
    end
    if @quick_pricer.arm_fixed_term && @quick_pricer.arm_fixed_term.any?
      @quick_pricer.arm_fixed_term.each do |aft|
        raw_xml << "  <DesiredMonthsToFirstRateAdjustment>#{aft}</DesiredMonthsToFirstRateAdjustment>"
      end
    end
    if @quick_pricer.loan_term && @quick_pricer.loan_term.any?
      @quick_pricer.loan_term.each do |lt|
        raw_xml << "  <DesiredLoanTermMonths>#{lt}</DesiredLoanTermMonths>"
      end
    end

    raw_xml << "     </MultiInstanceData>
                  </TransactionData>
                 </Request>
            </xmlRequest>
        </QuickSearch>
    </soap:Body>
</soap:Envelope>"

    response = soap_client.call(:quick_search, xml: raw_xml)
    response.body
  end

  private

  def soap_client
    Savon.client(wsdl: 'http://services.optimalblue.com/LoanServices/PricingServices.asmx?wsdl', endpoint: "https://services.optimalblue.com/loanservices/PricingServices.asmx?version=CommerceHomeMortgage.v1", element_form_default: :unqualified)
  end

end