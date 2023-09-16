pragma solidity >=0.5.0 <0.6.0;
import './ownable.sol';
contract DeadmanSwitch is Ownable{
    uint8 blocksCounter = 10;
    uint counter = 0;
    uint lastBlock=block.number;
    address payable _receiver = 0xAceAcA97FbAB5E83d26C5a4e20a561f79Ed462Ef;
    modifier not_alive() {
        require(block.number - lastBlock >= blocksCounter);
        _;
    }

    function still_alive() external onlyOwner{
        lastBlock = block.number;
    }

    function killswitch() public payable not_alive onlyOwner{
        uint256 balance = address(this).balance;
        _receiver.transfer(balance);
    }

    function dummy() external returns(uint){
        killswitch();
        return block.number;
    }
    function remaining_balance() external view returns(uint){
        return address(this).balance;
    }
    function initialBlock() external view returns(uint) {
        return block.number - lastBlock;
    }
}