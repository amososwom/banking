import Time "mo:base/Time";
import Trie "mo:base/Trie";

module {
    public type AccountNo = Nat;
    public type AccountType = {
        #Savings;
        #Checking;
        #FixedDeposit;
    };

    public type Account = {
        accountNo: AccountNo;
        customerID: Nat;
        accountType: AccountType;
        balance: Float;
        interestRate: Float;
        dateCreated: Time.Time;
        interestID: Nat;
        interestAmount: Float;
    };

    var accounts: Trie<AccountNo, Account> = Trie.empty();

    public func createAccount(account: Account): async AccountNo {
        let newID = Nat(accounts.size() + 1);
        accounts := accounts.put(newID, account);
        return newID;
    };

    public func getAccount(accountNo: AccountNo): async ?Account {
        return accounts.get(accountNo);
    };
}
