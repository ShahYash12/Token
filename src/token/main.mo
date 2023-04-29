import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Debug "mo:base/Debug";



actor Toke{
    var owner : Principal = Principal.fromText("bg3uy-g2czn-6325x-bkudn-p475i-rmi35-qtg37-7kvk6-3nmiy-hbex7-cae");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "DANG" ;


    var balances = HashMap.HashMap<Principal , Nat >(1,Principal.equal , Principal.hash);
    
    balances.put(owner , totalSupply);


    public query func balanceOf(who: Principal) : async Nat {
        let balance : Nat = switch(balances.get(who)){
            case null 0;
            case (?result) result;
        };

        return balance;
    
    };
    public query func getSymbol(): async Text {
        return symbol ;
    };

    public shared(msg) func payOut(): async Text {
        if (balances.get(msg.caller) == null ){
            //Debug.print(debug_show(msg.caller));
            let amount = 10000;
            balances.put(msg.caller , amount);
            return " Success"
        } else {
            return " Free tokens already claimed "
        };
        
       
    };

    public shared(msg) func transfer(to : Principal , amount : Nat): async Text {
        let fromBalance = await balanceOf(msg.caller);

        if (fromBalance > amount){
            let newFromBalance : Nat = fromBalance - amount ;
            balances.put(msg.caller ,newFromBalance);

            let toBalance = await balanceOf(to);
            let newToBalance : Nat = toBalance + amount ;

            balances.put(to , newToBalance);

            return "sucsess";
        }else{
            return "Insufficient Funds";
        };
    };
};