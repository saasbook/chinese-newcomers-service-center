class Item < ActiveRecord::Base
    
    def self.issue_types
        return %w(Income Deduction Credit Status Tax Penalty Collection)
    end
    
    def self.income_issues
        return ["Wages", "Interest / Dividens (Schedule B)", 
        "Business Income (Schedule C)", "Capital Gain or Loss (Schedule D)", 
        "IRA / Pension", "Social Security Benefits", "Alimony", "Rental, 
        Royalty, Partnership, S Corp (Schedule E)", "Farming Income (Schedule F)", 
        "Unemployment", "Gambling Winnings", "Cancellation of Debt", 
        "Settlement Proceeds", "Other"]
    end
    
    def self.deduction_issues
        return ["Alimony", "Education Expenses (Including student loan interest)", 
        "Moving Expenses", "IRA Deduction", "Medical and Dental Expenses", 
        "State and Local Taxes", "Home Mortgage Interest", "Other Interest Expenses", 
        "Charitable Contributions", "Casualty and Theft Losses", 
        "Unreimbursed Employee Business Expenses", "Other Itemized Deductions", 
        "Business Expenses (Schedule C)"]
    end
    
    def self.credit_issues
        return ["Child and Dependent Care Credit", "Education Credits", 
        "Child Tax Credit / Additional Child Tax Credit", 
        "Earned Income Tax Credit", "First-Time Homebuyer Credit", 
        "Premium Tax Credit", "Other Credits"]
    end
    
    def self.status_issues
        return ["SSN/ TIN", "ITIN", "Filing Status", "Personal/Dependency Exemptions", 
        "Injured Spouse", "Innocent Spouse", "Employment-Related Identify Theft", 
        "Refund-Related Identity Theft", "Nonfiler", "Worker Classification"]
    end
    
    def self.tax_refund_return_statue_limitations_issues
        return ["Self-Employment Tax", "Suspected Return Preparer Fraud", 
        "Estimated Tax Payments", "Withholdings", "Refund", "Assessment Statute of Limitations", 
        "Collection Statute of Limitations", "Collection Statute of Limitations", 
        "Refund Statute of Limitations"]
    end
    
    def self.penalty_addtion_tax_issues
        return ["Trust Fund Recovery Penalty", "Other Civil Penalties", 
        "Additional Tax on Distributions from Qualified Retirement Plans", 
        "Individual Shared Responsibility Payment"]
    end
    
    def self.collection_issues
        return ["Payments", "Installment Payment Agreement (IPA)", 
        "Offer-In-Compromise (OIC)", "Currently Not Collectible (CNC)", "Liens", 
        "Levies (Including Federal Payment Levy Program"]
    end
    
    def self.issues_and_types
        return [["Income", self.income_issues], ["Deduction", self.deduction_issues], ["Credit", self.credit_issues],
        ["Status", self.status_issues], ["Tax", self.tax_refund_return_statue_limitations_issues], ["Penalty", self.penalty_addtion_tax_issues], 
        ["Collection", self.collection_issues]]
    end

end
