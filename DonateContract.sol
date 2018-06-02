pragma solidity ^0.4.0;


contract DonateContract {

    struct Donation {
        uint id;
        uint value;
        string donor;
        string message; 
        address daddr;  
        address raddr;
    }

    Donation[] public donations;
    mapping (uint => Donation) public dMap;
    event NewDonation(uint uid, uint value, string donor, string message, address daddr, address raddr);

    function donate(address _receiver, string _name, string _message) public payable {
        require(msg.value >= 0);
        uint uid = donations.length;
        donations.push(Donation(uid, msg.value, _name, _message, msg.sender, _receiver));
        dMap[uid] = Donation(uid, msg.value, _name, _message, msg.sender, _receiver);
        NewDonation(uid, msg.value, _name, _message, msg.sender, _receiver);
        _receiver.transfer(msg.value);
    }

    function getDonation(uint _id) public view returns(uint value, string name, string mssg, address d, address r) {
        require(_id >= 0 && _id < donations.length);
        return(dMap[_id].value, dMap[_id].donor, dMap[_id].message, dMap[_id].daddr, dMap[_id].raddr);
    }
}