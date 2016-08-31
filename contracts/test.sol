import "dapple/test.sol";

contract C {

    uint[] arr;

    function add(uint val) {
        arr.push(val);
    }

    function get() constant returns (uint[]) {
        return arr;
    }

    function len() constant returns (uint) {
        return arr.length;
    }

}

contract D is Test {

    C c = new C();

    function add(uint val) {
        c.add(val);
    }

    function get() constant returns (uint[]) {
        var len = c.len();
        uint[] memory arr;
        address tgt = address(c);
        assembly {
          let btSz := add(mul(len, 32), 64) // amount of bytes needed to store 'arr'
          let memOffset := mload(0x40) // Next free memory slot is stored at 0x40 by Solidity.
          mstore(memOffset, mul(0x6d4ce63c, exp(256, 28))) // Need to add function identifier like this ('get' in this case).
          call(sub(gas, 25050), tgt, 0, memOffset, 4, memOffset, btSz)
          pop // Could check this for out of gas errors and such instead.
          mstore(0x40, add(memOffset, btSz)) // Update next free slot
          arr := add(memOffset, 32) // Assign the return memory to the array.
        }
        return arr;
    }

    function testDynamicSizedArrayReturn() {
      add(42);
      add(42);
      add(42);
      uint[] memory a = get();
      //@log a[1]=`uint a[1]`
      //@log length: `uint a.length`
    }
}
