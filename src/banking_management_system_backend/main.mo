import Trie "mo:base/Trie";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

// User data structure
public type User = {
    userId: Nat;
    username: Text;
    passwordHash: Text;
    role: { #Admin; #Customer; #Teller };
    email: Text;
    phoneNumber: Text;
    dateJoined: Text;
};

// Account data structure
public type Account = {
    accountId: Nat;
    userId: Nat;
    balance: Nat;
    accountType: { #Checking; #Savings };
    status: Text;
};

// Loan data structure
public type Loan = {
    loanId: Nat;
    userId: Nat;
    amount: Nat;
    interestRate: Float;
    termMonths: Nat;
    status: Text;
};

// Comparison function for Nat keys
func compareKeys(k1: Nat, k2: Nat): Bool {
    k1 == k2
}

// Main actor for the banking system
actor BankingSystem {

    var users: Trie.Trie<Nat, User> = Trie.empty();
    var accounts: Trie.Trie<Nat, Account> = Trie.empty();
    var loans: Trie.Trie<Nat, Loan> = Trie.empty();

    public func createUser(userId: Nat, username: Text, passwordHash: Text, role: { #Admin; #Customer; #Teller }, email: Text, phoneNumber: Text, dateJoined: Text): async Text {
        let user: User = {
            userId = userId;
            username = username;
            passwordHash = passwordHash;
            role = role;
            email = email;
            phoneNumber = phoneNumber;
            dateJoined = dateJoined;
        };
        users := Trie.put<Nat, User>(users, userId, compareKeys, user);
        return "User created successfully";
    };

    public func getUser(userId: Nat): async ?User {
        return Trie.get<Nat, User>(users, userId, compareKeys);
    };

    public func createAccount(accountId: Nat, userId: Nat, balance: Nat, accountType: { #Checking; #Savings }, status: Text): async Text {
        let account: Account = {
            accountId = accountId;
            userId = userId;
            balance = balance;
            accountType = accountType;
            status = status;
        };
        accounts := Trie.put<Nat, Account>(accounts, accountId, compareKeys, account);
        return "Account created successfully";
    };

    public func getAccount(accountId: Nat): async ?Account {
        return Trie.get<Nat, Account>(accounts, accountId, compareKeys);
    };

    public func deposit(accountId: Nat, amount: Nat): async Text {
        let accountOpt = Trie.get<Nat, Account>(accounts, accountId, compareKeys);
        switch (accountOpt) {
            case (?account) {
                let updatedAccount: Account = {
                    accountId = account.accountId;
                    userId = account.userId;
                    balance = Nat.add(account.balance, amount);
                    accountType = account.accountType;
                    status = account.status;
                };
                accounts := Trie.put<Nat, Account>(accounts, accountId, compareKeys, updatedAccount);
                return "Deposit successful";
            };
            case null { return "Account not found"; };
        }
    };

    public func withdraw(accountId: Nat, amount: Nat): async Text {
        let accountOpt = Trie.get<Nat, Account>(accounts, accountId, compareKeys);
        switch (accountOpt) {
            case (?account) {
                if (amount > account.balance) {
                    return "Insufficient balance";
                };
                let updatedAccount: Account = {
                    accountId = account.accountId;
                    userId = account.userId;
                    balance = Nat.sub(account.balance, amount);
                    accountType = account.accountType;
                    status = account.status;
                };
                accounts := Trie.put<Nat, Account>(accounts, accountId, compareKeys, updatedAccount);
                return "Withdrawal successful";
            };
            case null { return "Account not found"; };
        }
    };

    public func createLoan(loanId: Nat, userId: Nat, amount: Nat, interestRate: Float, termMonths: Nat, status: Text): async Text {
        let loan: Loan = {
            loanId = loanId;
            userId = userId;
            amount = amount;
            interestRate = interestRate;
            termMonths = termMonths;
            status = status;
        };
        loans := Trie.put<Nat, Loan>(loans, loanId, compareKeys, loan);
        return "Loan created successfully";
    };

    public func getLoan(loanId: Nat): async ?Loan {
        return Trie.get<Nat, Loan>(loans, loanId, compareKeys);
    };

    public func listUsers(): async [User] {
        return Iter.toArray(Trie.vals(users));
    };

    public func listAccounts(): async [Account] {
        return Iter.toArray(Trie.vals(accounts));
    };

    public func listLoans(): async [Loan] {
        return Iter.toArray(Trie.vals(loans));
    };
};
