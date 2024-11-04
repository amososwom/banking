// src/banking_management_system_backend/types.mo
import Time "mo:base/Time";

module {
  // Customer Data Model
  public type Customer = {
    customerID: Nat;
    firstName: Text;
    middleName: ?Text;  // Optional field
    lastName: Text;
    dateOfBirth: Text;
    gender: Text;
    email: Text;
    contact: Text;
    pan: Text;
    nationality: Text;
    salary: Float;
    address: Text;
  };

  // Account Data Model
  public type AccountType = {
    #Savings;
    #Checking;
    #FixedDeposit;
  };

  public type Account = {
    accountNo: Nat;
    customerID: Nat;
    accountType: AccountType;
    balance: Float;
    interestRate: Float;
    dateCreated: Time.Time;
    interestID: Nat;
    interestAmount: Float;
  };

  // Transaction Data Model
  public type TransactionType = {
    #Deposit;
    #Withdrawal;
    #Transfer;
  };

  public type Transaction = {
    transactionID: Nat;
    accountNo: Nat;
    transactionType: TransactionType;
    amount: Float;
    date: Time.Time;
    totalBalance: Float;
  };

  // Deposit Account Data Model
  public type DepositAccount = {
    depositAccountNo: Nat;
    accountNo: Nat;
    closureType: Text;
    interestID: Nat;
    initialAmount: Float;
    customerID: Nat;
    depositAccountType: AccountType;
    interestAmount: Float;
    currentBalance: Float;
    duration: Nat;  // Duration in days
    interestRate: Float;
    openDate: Time.Time;
    closeDate: ?Time.Time;
  };

  // Officer Data Model
  public type Officer = {
    employerID: Nat;
    username: Text;
    passwordHash: Text;
    email: Text;
    nationality: Text;
    salary: Float;
    address: Text;
    gender: Text;
    contact: Text;
    dateOfBirth: Text;
    firstName: Text;
    middleName: ?Text;
    lastName: Text;
  };

  // Manager Data Model
  public type Manager = {
    employerID: Nat;
    username: Text;
    passwordHash: Text;
    email: Text;
    nationality: Text;
    salary: Float;
    address: Text;
    gender: Text;
    contact: Text;
    dateOfBirth: Text;
    firstName: Text;
    middleName: ?Text;
    lastName: Text;
  };

  // Interest Data Model
  public type Interest = {
    interestID: Nat;
    savingsInterest: Float;
    loanInterest: Float;
    rdInterest: Float;
    fdInterest: Float;
    currentInterest: Float;
  };

  // Loan Account Data Model
  public type LoanAccount = {
    accountNo: Nat;
    loanID: Nat;
    loanType: Text;
    dateOfLoan: Time.Time;
    duration: Nat;
    totalAmount: Float;
    remainingAmount: Float;
    status: Text;
    description: Text;
    interest: Float;
  };
};
