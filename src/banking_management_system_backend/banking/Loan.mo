import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";

actor BankingSystem {

  // User roles
  public type Role = { #Customer; #Admin; #Teller };

  // User table
  public type User = {
    userId: Nat;
    username: Text;
    passwordHash: Text;
    role: Role;
    email: Text;
    phoneNumber: Text;
    dateJoined: Text;
  };

  // Initialize the users HashMap
  stable var users = HashMap.HashMap<Nat, User>(0, Nat.equal, Nat.hash);

  // User registration function
  public func registerUser(username: Text, passwordHash: Text, role: Role, email: Text, phoneNumber: Text, dateJoined: Text) : async Text {
    let userId = Nat(HashMap.size<Nat, User>(users) + 1);  // Generate a unique userId
    let newUser: User = {
        userId = userId;
        username = username;
        passwordHash = passwordHash;
        role = role;
        email = email;
        phoneNumber = phoneNumber;
        dateJoined = dateJoined;
    };
    users.put(userId, newUser);  // Add the user to the HashMap
    return "User registered with ID: " # Nat.toText(userId);
  };
}
