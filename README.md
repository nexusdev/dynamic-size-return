Todays dapp-a-day will go a little bit in another direction, which is more an experiment in solidity rather then a useful library. We all probably wanted at some time to pass an array between contracts. Currently this is a major pain point, since one has to specify in advance how long the return array will be. This is painful if we consider data which size we cannot estimate e.g. Array of stakeholder addresses. This case required complicated workarounds since the reason that this currently isn't supported by Solidity is because of a missing peace in the EVM which requires to allocate free memory space before the actual call. This dapp-a-day presents a workaround with two functions. One which is used to retrieve the length of the array and the next one which actually performs the function call. With this pattern sending dynamically sized arrays across contracts is no longer a problem!