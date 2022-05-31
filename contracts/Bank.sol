// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract Bank {

	struct Payment {
		uint amount;
		address from;
		uint timestamp;
		string message;
	}

	struct Balance {
		uint totalPayment;
		mapping (uint => Payment) payments;
	}

	mapping(address => Balance) public balances;

	function pay (string memory message) public payable {
		uint paymentNumber = balances[msg.sender].totalPayment;
		balances[msg.sender].totalPayment++;

		Payment memory newPayment = Payment(
			msg.value,
			msg.sender,
			block.timestamp,
			message
		);

		balances[msg.sender].payments[paymentNumber] = newPayment;
	}

	function getPayments(address _from, uint _index) public view returns(Payment memory) {
		return balances[_from].payments[_index];
	}
}
