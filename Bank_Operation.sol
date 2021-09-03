pragma solidity ^0.4.26;
 
contract Bank_Operation
{
	struct customer{
	    address eth_customer;
	    string name_of_customer;
		string address_of_customer;
		uint mobile;
		uint balances;
		uint valid;
	}
	
	address public owner;
	mapping(address => customer) public account_holder;	
		
	constructor() public{
		owner = msg.sender;
	}
	
	function Registration_of_customer(address ip_eth_customer,string ip_name_of_customer,string ip_address_of_customer,uint ip_mobile) public{
		require(msg.sender == owner, "Only owner is authorized to open an account for the customer.");
		require(account_holder[ip_eth_customer].valid==0,"The customer with this Ethereum Address already registered.");
		account_holder[ip_eth_customer].eth_customer = ip_eth_customer;
		account_holder[ip_eth_customer].name_of_customer = ip_name_of_customer;
		account_holder[ip_eth_customer].address_of_customer = ip_address_of_customer;
		account_holder[ip_eth_customer].mobile = ip_mobile;
		account_holder[ip_eth_customer].balances = 0;
		account_holder[ip_eth_customer].valid = 1;
	}
	
	function deposit(uint amount) public returns(uint){
		require(account_holder[msg.sender].valid==1,"This account holder doesnot exist.");
		account_holder[msg.sender].balances += amount;
		return account_holder[msg.sender].balances;
	}
	
	function withdrawal(uint amount) public returns(uint){
		require(account_holder[msg.sender].valid==1,"This account holder doesnot exist.");
		account_holder[msg.sender].balances -= amount;
		return account_holder[msg.sender].balances;
	}
	
	function balance_check() public view returns(uint){
		require(account_holder[msg.sender].valid==1,"This account holder doesnot exist.");
		return account_holder[msg.sender].balances;
	}
	
	function Money_Transfer(address ip_eth_customer,uint amount)public returns(uint){
		require(account_holder[msg.sender].valid==1,"Sender account holder doesnot exist.");
		require(account_holder[ip_eth_customer].valid==1,"Receiver account holder doesnot exist.");
		require(account_holder[msg.sender].balances > amount,"Sender account holder doesnot have sufficient balance.");
		account_holder[msg.sender].balances -= amount;
		account_holder[ip_eth_customer].balances += amount;
		return account_holder[msg.sender].balances;
	}
	
	function Close_Account(address ip_eth_customer) public{
		require(msg.sender == owner, "Only owner is authorized to close an account for the customer.");
		require(account_holder[ip_eth_customer].valid==1,"Account holder doesnot exist.");
		require(account_holder[ip_eth_customer].balances == 0, "Kindly withdrawal all your money, then apply for closure of account");
		account_holder[ip_eth_customer].valid = 0;
	}

}

	
