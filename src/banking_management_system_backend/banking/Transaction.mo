import Time "mo:base/Time";

module {
    public type TransactionID = Nat;
    public type TransactionType = {
        #Deposit;
        #Withdrawal;
        #Transfer;
    };

    public type Transaction = {
        transactionID: TransactionID;
        accountNo: Nat;
        transactionType: TransactionType;
        amount: Float;
        date: Time.Time;
        totalBalance: Float;
    };

    var transactions: Trie<TransactionID, Transaction> = Trie.empty();

    public func processTransaction(transaction: Transaction): async Bool {
        let newID = Nat(transactions.size() + 1);
        transactions := transactions.put(newID, transaction);
        return true;
    };

    public func getTransaction(transactionID: TransactionID): async ?Transaction {
        return transactions.get(transactionID);
    };
}
