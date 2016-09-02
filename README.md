y's dapp we're going a little bit in yet another direction.
It's not so much a dapp per se, but more of an implementation pattern.

A lot of people reading this probably wanted at some point to pass an
array between contracts. This is a major pain point because you
actually have to specify in advance how long the return array will be.

This is painful if we consider data whose size we cannot estimate,
such as an array of stakeholder addresses. This case has required
complicated workarounds, since the reason that this currently isn't
supported by Solidity is because of a missing peace in the EVM which
requires the caller to allocate free memory space before the call.

Well, this dapp presents a workaround, consisting of two functions and
a bit of assembly. The first fuction is used to retrieve the array
length, and then the second one actually performs the function call.

With this pattern, sending dynamically sized arrays across contracts
is no longer a problem!

Run it with `dapple test --report`
Should produce the following output:
```
Testing...

D
  test dynamic sized array return
  LOG:  a[1]=2a
  LOG:  length: 3
  Passed!

Summary
  Passed all 1 tests!
```
