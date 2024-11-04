import HashMap "mo:base/HashMap";

module {
    public type CustomerID = Nat;
    public type Customer = {
        customerID: CustomerID;
        firstName: Text;
        middleName: ?Text;
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

    var customers: HashMap<CustomerID, Customer> = HashMap.empty();

    public func createCustomer(customer: Customer): async CustomerID {
        let newID = Nat(customers.size() + 1);
        customers := HashMap.put(customers, newID, customer);
        return newID;
    };

    public func getCustomer(customerID: CustomerID): async ?Customer {
        return HashMap.get(customers, customerID);
    };
}
