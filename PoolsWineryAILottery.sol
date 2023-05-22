/**
 *Submitted for verification at BscScan.com on 2022-07-13
 */

/**
 *Submitted for verification at BscScan.com on 2022-04-18
 */

/**
 *Submitted for verification at BscScan.com on 2022-03-29
 */

/**
 *Submitted for verification at BscScan.com on 2022-02-14
 */

// SPDX-License-Identifier: MIT

// File: contracts/IBEP20.sol

pragma solidity >=0.6.0 <0.8.0;

interface IBEP20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address _owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
// File: contracts/LotteryOwnable.sol

pragma solidity 0.6.12;

/*
 * ApeSwapFinance
 * App:             https://apeswap.finance
 * Medium:          https://ape-swap.medium.com
 * Twitter:         https://twitter.com/ape_swap
 * Telegram:        https://t.me/ape_swap
 * Announcements:   https://t.me/ape_swap_news
 * GitHub:          https://github.com/ApeSwapFinance
 */

contract LotteryOwnable {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {}

    function initOwner(address owner) internal {
        _owner = owner;
        emit OwnershipTransferred(address(0), owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
// File: contracts/Strings.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev String operations.
 */
library Strings {
    /**
     * @dev Converts a `uint256` to its ASCII `string` representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;
        temp = value;
        while (temp != 0) {
            buffer[index--] = bytes1(uint8(48 + (temp % 10)));
            temp /= 10;
        }
        return string(buffer);
    }
}
// File: contracts/EnumerableMap.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Library for managing an enumerable variant of Solidity's
 * https://solidity.readthedocs.io/en/latest/types.html#mapping-types[`mapping`]
 * type.
 *
 * Maps have the following properties:
 *
 * - Entries are added, removed, and checked for existence in constant time
 * (O(1)).
 * - Entries are enumerated in O(n). No guarantees are made on the ordering.
 *
 * ```
 * contract Example {
 *     // Add the library methods
 *     using EnumerableMap for EnumerableMap.UintToAddressMap;
 *
 *     // Declare a set state variable
 *     EnumerableMap.UintToAddressMap private myMap;
 * }
 * ```
 *
 * As of v3.0.0, only maps of type `uint256 -> address` (`UintToAddressMap`) are
 * supported.
 */
library EnumerableMap {
    // To implement this library for multiple types with as little code
    // repetition as possible, we write it in terms of a generic Map type with
    // bytes32 keys and values.
    // The Map implementation uses private functions, and user-facing
    // implementations (such as Uint256ToAddressMap) are just wrappers around
    // the underlying Map.
    // This means that we can only create new EnumerableMaps for types that fit
    // in bytes32.

    struct MapEntry {
        bytes32 _key;
        bytes32 _value;
    }

    struct Map {
        // Storage of map keys and values
        MapEntry[] _entries;
        // Position of the entry defined by a key in the `entries` array, plus 1
        // because index 0 means a key is not in the map.
        mapping(bytes32 => uint256) _indexes;
    }

    /**
     * @dev Adds a key-value pair to a map, or updates the value for an existing
     * key. O(1).
     *
     * Returns true if the key was added to the map, that is if it was not
     * already present.
     */
    function _set(
        Map storage map,
        bytes32 key,
        bytes32 value
    ) private returns (bool) {
        // We read and store the key's index to prevent multiple reads from the same storage slot
        uint256 keyIndex = map._indexes[key];

        if (keyIndex == 0) {
            // Equivalent to !contains(map, key)
            map._entries.push(MapEntry({_key: key, _value: value}));
            // The entry is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            map._indexes[key] = map._entries.length;
            return true;
        } else {
            map._entries[keyIndex - 1]._value = value;
            return false;
        }
    }

    /**
     * @dev Removes a key-value pair from a map. O(1).
     *
     * Returns true if the key was removed from the map, that is if it was present.
     */
    function _remove(Map storage map, bytes32 key) private returns (bool) {
        // We read and store the key's index to prevent multiple reads from the same storage slot
        uint256 keyIndex = map._indexes[key];

        if (keyIndex != 0) {
            // Equivalent to contains(map, key)
            // To delete a key-value pair from the _entries array in O(1), we swap the entry to delete with the last one
            // in the array, and then remove the last entry (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = keyIndex - 1;
            uint256 lastIndex = map._entries.length - 1;

            // When the entry to delete is the last one, the swap operation is unnecessary. However, since this occurs
            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.

            MapEntry storage lastEntry = map._entries[lastIndex];

            // Move the last entry to the index where the entry to delete is
            map._entries[toDeleteIndex] = lastEntry;
            // Update the index for the moved entry
            map._indexes[lastEntry._key] = toDeleteIndex + 1; // All indexes are 1-based

            // Delete the slot where the moved entry was stored
            map._entries.pop();

            // Delete the index for the deleted slot
            delete map._indexes[key];

            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Returns true if the key is in the map. O(1).
     */
    function _contains(
        Map storage map,
        bytes32 key
    ) private view returns (bool) {
        return map._indexes[key] != 0;
    }

    /**
     * @dev Returns the number of key-value pairs in the map. O(1).
     */
    function _length(Map storage map) private view returns (uint256) {
        return map._entries.length;
    }

    /**
     * @dev Returns the key-value pair stored at position `index` in the map. O(1).
     *
     * Note that there are no guarantees on the ordering of entries inside the
     * array, and it may change when more entries are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function _at(
        Map storage map,
        uint256 index
    ) private view returns (bytes32, bytes32) {
        require(
            map._entries.length > index,
            "EnumerableMap: index out of bounds"
        );

        MapEntry storage entry = map._entries[index];
        return (entry._key, entry._value);
    }

    /**
     * @dev Tries to returns the value associated with `key`.  O(1).
     * Does not revert if `key` is not in the map.
     */
    function _tryGet(
        Map storage map,
        bytes32 key
    ) private view returns (bool, bytes32) {
        uint256 keyIndex = map._indexes[key];
        if (keyIndex == 0) return (false, 0); // Equivalent to contains(map, key)
        return (true, map._entries[keyIndex - 1]._value); // All indexes are 1-based
    }

    /**
     * @dev Returns the value associated with `key`.  O(1).
     *
     * Requirements:
     *
     * - `key` must be in the map.
     */
    function _get(Map storage map, bytes32 key) private view returns (bytes32) {
        uint256 keyIndex = map._indexes[key];
        require(keyIndex != 0, "EnumerableMap: nonexistent key"); // Equivalent to contains(map, key)
        return map._entries[keyIndex - 1]._value; // All indexes are 1-based
    }

    /**
     * @dev Same as {_get}, with a custom error message when `key` is not in the map.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {_tryGet}.
     */
    function _get(
        Map storage map,
        bytes32 key,
        string memory errorMessage
    ) private view returns (bytes32) {
        uint256 keyIndex = map._indexes[key];
        require(keyIndex != 0, errorMessage); // Equivalent to contains(map, key)
        return map._entries[keyIndex - 1]._value; // All indexes are 1-based
    }

    // UintToAddressMap

    struct UintToAddressMap {
        Map _inner;
    }

    /**
     * @dev Adds a key-value pair to a map, or updates the value for an existing
     * key. O(1).
     *
     * Returns true if the key was added to the map, that is if it was not
     * already present.
     */
    function set(
        UintToAddressMap storage map,
        uint256 key,
        address value
    ) internal returns (bool) {
        return _set(map._inner, bytes32(key), bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the key was removed from the map, that is if it was present.
     */
    function remove(
        UintToAddressMap storage map,
        uint256 key
    ) internal returns (bool) {
        return _remove(map._inner, bytes32(key));
    }

    /**
     * @dev Returns true if the key is in the map. O(1).
     */
    function contains(
        UintToAddressMap storage map,
        uint256 key
    ) internal view returns (bool) {
        return _contains(map._inner, bytes32(key));
    }

    /**
     * @dev Returns the number of elements in the map. O(1).
     */
    function length(
        UintToAddressMap storage map
    ) internal view returns (uint256) {
        return _length(map._inner);
    }

    /**
     * @dev Returns the element stored at position `index` in the set. O(1).
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(
        UintToAddressMap storage map,
        uint256 index
    ) internal view returns (uint256, address) {
        (bytes32 key, bytes32 value) = _at(map._inner, index);
        return (uint256(key), address(uint160(uint256(value))));
    }

    /**
     * @dev Tries to returns the value associated with `key`.  O(1).
     * Does not revert if `key` is not in the map.
     *
     * _Available since v3.4._
     */
    function tryGet(
        UintToAddressMap storage map,
        uint256 key
    ) internal view returns (bool, address) {
        (bool success, bytes32 value) = _tryGet(map._inner, bytes32(key));
        return (success, address(uint160(uint256(value))));
    }

    /**
     * @dev Returns the value associated with `key`.  O(1).
     *
     * Requirements:
     *
     * - `key` must be in the map.
     */
    function get(
        UintToAddressMap storage map,
        uint256 key
    ) internal view returns (address) {
        return address(uint160(uint256(_get(map._inner, bytes32(key)))));
    }

    /**
     * @dev Same as {get}, with a custom error message when `key` is not in the map.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryGet}.
     */
    function get(
        UintToAddressMap storage map,
        uint256 key,
        string memory errorMessage
    ) internal view returns (address) {
        return
            address(
                uint160(uint256(_get(map._inner, bytes32(key), errorMessage)))
            );
    }
}
// File: contracts/EnumerableSet.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Library for managing
 * https://en.wikipedia.org/wiki/Set_(abstract_data_type)[sets] of primitive
 * types.
 *
 * Sets have the following properties:
 *
 * - Elements are added, removed, and checked for existence in constant time
 * (O(1)).
 * - Elements are enumerated in O(n). No guarantees are made on the ordering.
 *
 * ```
 * contract Example {
 *     // Add the library methods
 *     using EnumerableSet for EnumerableSet.AddressSet;
 *
 *     // Declare a set state variable
 *     EnumerableSet.AddressSet private mySet;
 * }
 * ```
 *
 * As of v3.3.0, sets of type `bytes32` (`Bytes32Set`), `address` (`AddressSet`)
 * and `uint256` (`UintSet`) are supported.
 */
library EnumerableSet {
    // To implement this library for multiple types with as little code
    // repetition as possible, we write it in terms of a generic Set type with
    // bytes32 values.
    // The Set implementation uses private functions, and user-facing
    // implementations (such as AddressSet) are just wrappers around the
    // underlying Set.
    // This means that we can only create new EnumerableSets for types that fit
    // in bytes32.

    struct Set {
        // Storage of set values
        bytes32[] _values;
        // Position of the value in the `values` array, plus 1 because index 0
        // means a value is not in the set.
        mapping(bytes32 => uint256) _indexes;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function _add(Set storage set, bytes32 value) private returns (bool) {
        if (!_contains(set, value)) {
            set._values.push(value);
            // The value is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            set._indexes[value] = set._values.length;
            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function _remove(Set storage set, bytes32 value) private returns (bool) {
        // We read and store the value's index to prevent multiple reads from the same storage slot
        uint256 valueIndex = set._indexes[value];

        if (valueIndex != 0) {
            // Equivalent to contains(set, value)
            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
            // the array, and then remove the last element (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;

            // When the value to delete is the last one, the swap operation is unnecessary. However, since this occurs
            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.

            bytes32 lastvalue = set._values[lastIndex];

            // Move the last value to the index where the value to delete is
            set._values[toDeleteIndex] = lastvalue;
            // Update the index for the moved value
            set._indexes[lastvalue] = toDeleteIndex + 1; // All indexes are 1-based

            // Delete the slot where the moved value was stored
            set._values.pop();

            // Delete the index for the deleted slot
            delete set._indexes[value];

            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function _contains(
        Set storage set,
        bytes32 value
    ) private view returns (bool) {
        return set._indexes[value] != 0;
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function _length(Set storage set) private view returns (uint256) {
        return set._values.length;
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function _at(
        Set storage set,
        uint256 index
    ) private view returns (bytes32) {
        require(
            set._values.length > index,
            "EnumerableSet: index out of bounds"
        );
        return set._values[index];
    }

    // Bytes32Set

    struct Bytes32Set {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(
        Bytes32Set storage set,
        bytes32 value
    ) internal returns (bool) {
        return _add(set._inner, value);
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(
        Bytes32Set storage set,
        bytes32 value
    ) internal returns (bool) {
        return _remove(set._inner, value);
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(
        Bytes32Set storage set,
        bytes32 value
    ) internal view returns (bool) {
        return _contains(set._inner, value);
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(Bytes32Set storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(
        Bytes32Set storage set,
        uint256 index
    ) internal view returns (bytes32) {
        return _at(set._inner, index);
    }

    // AddressSet

    struct AddressSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(
        AddressSet storage set,
        address value
    ) internal returns (bool) {
        return _add(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(
        AddressSet storage set,
        address value
    ) internal returns (bool) {
        return _remove(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(
        AddressSet storage set,
        address value
    ) internal view returns (bool) {
        return _contains(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(AddressSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(
        AddressSet storage set,
        uint256 index
    ) internal view returns (address) {
        return address(uint160(uint256(_at(set._inner, index))));
    }

    // UintSet

    struct UintSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(UintSet storage set, uint256 value) internal returns (bool) {
        return _add(set._inner, bytes32(value));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(
        UintSet storage set,
        uint256 value
    ) internal returns (bool) {
        return _remove(set._inner, bytes32(value));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(
        UintSet storage set,
        uint256 value
    ) internal view returns (bool) {
        return _contains(set._inner, bytes32(value));
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function length(UintSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(
        UintSet storage set,
        uint256 index
    ) internal view returns (uint256) {
        return uint256(_at(set._inner, index));
    }
}
// File: contracts/Address.sol

pragma solidity >=0.6.2 <0.8.0;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data
    ) internal view returns (bytes memory) {
        return
            functionStaticCall(
                target,
                data,
                "Address: low-level static call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return
            functionDelegateCall(
                target,
                data,
                "Address: low-level delegate call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}
// File: contracts/Initializable.sol

// solhint-disable-next-line compiler-version
pragma solidity >=0.4.24 <0.8.0;

/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since a proxied contract can't have a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {UpgradeableProxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     */
    bool private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Modifier to protect an initializer function from being invoked twice.
     */
    modifier initializer() {
        require(
            _initializing || _isConstructor() || !_initialized,
            "Initializable: contract is already initialized"
        );

        bool isTopLevelCall = !_initializing;
        if (isTopLevelCall) {
            _initializing = true;
            _initialized = true;
        }

        _;

        if (isTopLevelCall) {
            _initializing = false;
        }
    }

    /// @dev Returns true if and only if the function is running in the constructor
    function _isConstructor() private view returns (bool) {
        return !Address.isContract(address(this));
    }
}
// File: contracts/SafeMath.sol

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
}

// File: contracts/Context.sol
pragma solidity >=0.6.0 <0.8.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: contracts/Ownable.sol
pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: contracts/Lottery.sol
pragma solidity 0.6.12;

// 4 numbers
contract PoolsWineryAILottery is LotteryOwnable, Initializable {
    using SafeMath for uint256;
    using SafeMath for uint8;

    address constant burnAddress =
        address(0x000000000000000000000000000000000000dEaD);

    uint8 constant keyLengthForEachBuy = 11;
    // Allocation for first/sencond/third reward
    uint8[3] public allocation;
    // Allocation for rollover
    uint8 public rolloverAllocation;
    // The TOKEN to buy lottery
    IBEP20 public winery;

    // // The Lottery NFT for tickets
    // LotteryNFT public lotteryNFT;

    // treasuryAddress
    address public treasuryAddress;
    // adminAddress
    address public adminAddress;
    // maxNumber
    uint8 public maxNumber;
    // minPrice, if decimal is not 18, please reset it
    uint256 public minPrice;

    uint256 public lotteryId;

    struct LotteryStructInfo {
        address user;
        uint256 total; // How many tokens the user has transfer.
        uint8[4] numbers;
        bool isClaimed;
        uint256 time;
        uint256 issueIndex;
    }

    // =================================
    mapping(uint256 => LotteryStructInfo) public lotteryBuyInfo;
    // LotteryStructInfo[] public lotteryBuyInfo;
    // issueId => winningNumbers[numbers]
    mapping(uint256 => uint8[4]) public historyNumbers;
    // issueId => [tokenId]
    mapping(uint256 => uint256[]) public lotteryInfo;
    // issueId => [totalAmount, firstMatchAmount, secondMatchingAmount, thirdMatchingAmount]
    mapping(uint256 => uint256[]) public historyAmount;
    // issueId => trickyNumber => buyAmountSum
    mapping(uint256 => mapping(uint64 => uint256)) public userBuyAmountSum;
    // address => [tokenId]
    mapping(address => uint256[]) public userInfo;
    // address => issueIndex => [tokenId]
    mapping(address => mapping(uint256 => uint256[])) public userHistory;

    uint256 public issueIndex = 0;
    uint256 public totalAddresses = 0;
    uint256 public totalAmount = 0;
    uint256 public lastTimestamp;
    uint256 public nextTimeDraw = 0;

    uint8[4] public winningNumbers;

    // default false
    bool public drawingPhase;

    // =================================

    event Buy(address indexed user, uint256 tokenId);
    event Drawing(uint256 indexed issueIndex, uint8[4] winningNumbers);
    event Claim(address indexed user, uint256 tokenid, uint256 amount);
    event DevWithdraw(address indexed user, uint256 amount);
    event Reset(
        uint256 indexed issueIndex,
        uint256 unclaimableRewards,
        uint256 burnAmount
    );
    event MultiClaim(address indexed user, uint256 amount);
    event MultiBuy(address indexed user, uint256 amount);

    constructor() public {}

    function initialize(
        IBEP20 _winery,
        // LotteryNFT _lottery,
        uint256 _minPrice,
        uint8 _maxNumber,
        address _owner,
        address _adminAddress,
        address _treasuryAddress,
        uint256 _nextTime
    ) public initializer {
        winery = _winery;
        // lotteryNFT = _lottery;
        minPrice = _minPrice;
        maxNumber = _maxNumber;
        adminAddress = _adminAddress;
        treasuryAddress = _treasuryAddress;
        lastTimestamp = block.timestamp;
        rolloverAllocation = 5;
        _setAllocation(65, 20, 10);
        initOwner(_owner);
        lotteryId = 0;
        nextTimeDraw = _nextTime;
    }

    uint8[4] private nullTicket = [0, 0, 0, 0];

    modifier onlyAdmin() {
        require(msg.sender == adminAddress, "admin: wut?");
        _;
    }

    function drawed() public view returns (bool) {
        return winningNumbers[0] != 0;
    }

    function burnAllocation() public view returns (uint8) {
        uint8 rewardAllocation = rolloverAllocation;
        for (uint8 i = 0; i < allocation.length; i++) {
            rewardAllocation = rewardAllocation + allocation[i];
        }
        return 100 - rewardAllocation;
    }

    function reset() internal onlyAdmin {
        //require(drawed(), "drawed?");
        lastTimestamp = block.timestamp;
        totalAddresses = 0;
        totalAmount = 0;
        winningNumbers[0] = 0;
        winningNumbers[1] = 0;
        winningNumbers[2] = 0;
        winningNumbers[3] = 0;
        drawingPhase = false;
        issueIndex++;
        uint256 rolloverAmount = 0;
        uint256 previousRewards = getTotalRewards(issueIndex - 1);
        // Calculate unclaimable rewards from previous issueIndex and add to rollover
        for (uint i = 0; i < allocation.length; i++) {
            if (getMatchingRewardAmount(issueIndex - 1, 4 - i) == 0) {
                rolloverAmount = rolloverAmount.add(
                    (previousRewards.mul(allocation[i])).div(100)
                );
            }
        }
        // Calculate roll over balance
        rolloverAmount = rolloverAmount.add(
            (previousRewards.mul(rolloverAllocation)).div(100)
        );

        if (rolloverAmount > 0) {
            internalBuy(rolloverAmount, nullTicket);
        }
    }

    function enterDrawingPhase() external onlyAdmin {
        require(!drawed(), "drawed");
        drawingPhase = true;
    }

    function setMainToken(IBEP20 _newToken) public onlyAdmin {
        winery = _newToken;
    }

    function getNumbersTicket(
        uint256 _lotteryId
    ) public view returns (uint8[4] memory) {
        return lotteryBuyInfo[_lotteryId].numbers;
    }

    // add externalRandomNumber to prevent node validators exploiting
    function drawing(uint256 _nextTime) external onlyAdmin {
        require(!drawed(), "reset?");
        require(drawingPhase, "enter drawing phase first");

        winningNumbers[0] = random(1 + block.timestamp);

        winningNumbers[1] = random(2 + block.timestamp);

        winningNumbers[2] = random(3 + block.timestamp);

        winningNumbers[3] = random(4 + block.timestamp);

        historyNumbers[issueIndex] = winningNumbers;
        historyAmount[issueIndex] = calculateMatchingRewardAmount();
        drawingPhase = false;

        nextTimeDraw = _nextTime;
        reset();
        emit Drawing(issueIndex, winningNumbers);
    }

    function internalBuy(uint256 _price, uint8[4] memory _numbers) internal {
        require(!drawed(), "drawed, can not buy now");
        for (uint i = 0; i < 4; i++) {
            require(_numbers[i] <= maxNumber, "exceed the maximum");
        }
        lotteryBuyInfo[lotteryId].user = msg.sender;
        lotteryBuyInfo[lotteryId].total = _price;
        lotteryBuyInfo[lotteryId].isClaimed = false;
        lotteryBuyInfo[lotteryId].time = block.timestamp;
        lotteryBuyInfo[lotteryId].issueIndex = issueIndex;
        lotteryBuyInfo[lotteryId].numbers = _numbers;

        lotteryInfo[issueIndex].push(lotteryId);
        totalAmount = totalAmount.add(_price);
        lastTimestamp = block.timestamp;

        lotteryId++;
        emit Buy(address(this), lotteryId - 1);
    }

    function approveTransfer(uint256 _price) public returns (bool) {
        return winery.approve(address(this), _price);
    }

    function buy(
        uint256 _price,
        uint8[4] memory _numbers
    ) external returns (uint256) {
        require(!drawed(), "drawed, can not buy now");
        require(!drawingPhase, "drawing, can not buy now");
        require(_price >= minPrice, "price must above minPrice");
        for (uint i = 0; i < 4; i++) {
            require(_numbers[i] <= maxNumber, "exceed number scope");
        }

        lotteryBuyInfo[lotteryId].user = msg.sender;
        lotteryBuyInfo[lotteryId].total = _price;
        lotteryBuyInfo[lotteryId].isClaimed = false;
        lotteryBuyInfo[lotteryId].time = block.timestamp;
        lotteryBuyInfo[lotteryId].issueIndex = issueIndex;
        lotteryBuyInfo[lotteryId].numbers = _numbers;

        lotteryInfo[issueIndex].push(lotteryId);
        if (userInfo[msg.sender].length == 0) {
            totalAddresses = totalAddresses + 1;
        }
        userInfo[msg.sender].push(lotteryId);
        totalAmount = totalAmount.add(_price);
        lastTimestamp = block.timestamp;
        uint64[keyLengthForEachBuy]
            memory userNumberIndex = generateNumberIndexKey(_numbers);
        for (uint i = 0; i < keyLengthForEachBuy; i++) {
            userBuyAmountSum[issueIndex][userNumberIndex[i]] = userBuyAmountSum[
                issueIndex
            ][userNumberIndex[i]].add(_price);
        }

        userHistory[msg.sender][issueIndex].push(lotteryId);

        lotteryId++;

        winery.transferFrom(
            address(msg.sender),
            address(treasuryAddress),
            _price
        );
        emit Buy(msg.sender, lotteryId - 1);
    }

    function multiBuy(uint256 _price, uint8[4][] memory _numbers) external {
        require(!drawed(), "drawed, can not buy now");
        require(_price >= minPrice, "price must above minPrice");
        uint256 totalPrice = 0;
        for (uint i = 0; i < _numbers.length; i++) {
            for (uint j = 0; j < 4; j++) {
                require(
                    _numbers[i][j] <= maxNumber && _numbers[i][j] > 0,
                    "exceed number scope"
                );
            }

            lotteryBuyInfo[lotteryId].user = msg.sender;
            lotteryBuyInfo[lotteryId].total = _price;
            lotteryBuyInfo[lotteryId].isClaimed = false;
            lotteryBuyInfo[lotteryId].time = block.timestamp;
            lotteryBuyInfo[lotteryId].issueIndex = issueIndex;
            lotteryBuyInfo[lotteryId].numbers = _numbers[i];

            lotteryInfo[issueIndex].push(lotteryId);
            if (userInfo[msg.sender].length == 0) {
                totalAddresses = totalAddresses + 1;
            }
            userInfo[msg.sender].push(lotteryId);
            totalAmount = totalAmount.add(_price);
            lastTimestamp = block.timestamp;
            totalPrice = totalPrice.add(_price);

            userHistory[msg.sender][issueIndex].push(lotteryId);

            uint64[keyLengthForEachBuy]
                memory numberIndexKey = generateNumberIndexKey(_numbers[i]);
            for (uint k = 0; k < keyLengthForEachBuy; k++) {
                userBuyAmountSum[issueIndex][
                    numberIndexKey[k]
                ] = userBuyAmountSum[issueIndex][numberIndexKey[k]].add(_price);
            }

            lotteryId++;
        }

        winery.transferFrom(
            address(msg.sender),
            address(treasuryAddress),
            totalPrice
        );

        emit MultiBuy(msg.sender, totalPrice);
    }

    function claimReward(uint256 _lotteryId) external {
        require(
            msg.sender == lotteryBuyInfo[_lotteryId].user,
            "not from owner"
        );
        require(!lotteryBuyInfo[_lotteryId].isClaimed, "claimed");
        uint256 reward = getRewardView(_lotteryId);

        lotteryBuyInfo[_lotteryId].isClaimed = true;
        if (reward > 0) {
            winery.transferFrom(
                address(treasuryAddress),
                address(msg.sender),
                reward
            );
        }
        emit Claim(msg.sender, _lotteryId, reward);
    }

    function multiClaim(uint256[] memory _tickets) external {
        uint256 totalReward = 0;
        for (uint i = 0; i < _tickets.length; i++) {
            require(
                msg.sender == lotteryBuyInfo[_tickets[i]].user,
                "not from owner"
            );
            require(!lotteryBuyInfo[_tickets[i]].isClaimed, "claimed");
            uint256 reward = getRewardView(_tickets[i]);
            if (reward > 0) {
                totalReward = reward.add(totalReward);
            }
        }

        for (uint i = 0; i < _tickets.length; i++) {
            lotteryBuyInfo[_tickets[i]].isClaimed = true;
        }

        if (totalReward > 0) {
            winery.transferFrom(
                address(treasuryAddress),
                address(msg.sender),
                totalReward
            );
        }
        emit MultiClaim(msg.sender, totalReward);
    }

    function generateNumberIndexKey(
        uint8[4] memory number
    ) public pure returns (uint64[keyLengthForEachBuy] memory) {
        uint64[4] memory tempNumber;
        tempNumber[0] = uint64(number[0]);
        tempNumber[1] = uint64(number[1]);
        tempNumber[2] = uint64(number[2]);
        tempNumber[3] = uint64(number[3]);

        uint64[keyLengthForEachBuy] memory result;
        result[0] =
            tempNumber[0] *
            256 *
            256 *
            256 *
            256 *
            256 *
            256 +
            1 *
            256 *
            256 *
            256 *
            256 *
            256 +
            tempNumber[1] *
            256 *
            256 *
            256 *
            256 +
            2 *
            256 *
            256 *
            256 +
            tempNumber[2] *
            256 *
            256 +
            3 *
            256 +
            tempNumber[3];

        result[1] =
            tempNumber[0] *
            256 *
            256 *
            256 *
            256 +
            1 *
            256 *
            256 *
            256 +
            tempNumber[1] *
            256 *
            256 +
            2 *
            256 +
            tempNumber[2];
        result[2] =
            tempNumber[0] *
            256 *
            256 *
            256 *
            256 +
            1 *
            256 *
            256 *
            256 +
            tempNumber[1] *
            256 *
            256 +
            3 *
            256 +
            tempNumber[3];
        result[3] =
            tempNumber[0] *
            256 *
            256 *
            256 *
            256 +
            2 *
            256 *
            256 *
            256 +
            tempNumber[2] *
            256 *
            256 +
            3 *
            256 +
            tempNumber[3];
        result[4] =
            1 *
            256 *
            256 *
            256 *
            256 *
            256 +
            tempNumber[1] *
            256 *
            256 *
            256 *
            256 +
            2 *
            256 *
            256 *
            256 +
            tempNumber[2] *
            256 *
            256 +
            3 *
            256 +
            tempNumber[3];

        result[5] = tempNumber[0] * 256 * 256 + 1 * 256 + tempNumber[1];
        result[6] = tempNumber[0] * 256 * 256 + 2 * 256 + tempNumber[2];
        result[7] = tempNumber[0] * 256 * 256 + 3 * 256 + tempNumber[3];
        result[8] =
            1 *
            256 *
            256 *
            256 +
            tempNumber[1] *
            256 *
            256 +
            2 *
            256 +
            tempNumber[2];
        result[9] =
            1 *
            256 *
            256 *
            256 +
            tempNumber[1] *
            256 *
            256 +
            3 *
            256 +
            tempNumber[3];
        result[10] =
            2 *
            256 *
            256 *
            256 +
            tempNumber[2] *
            256 *
            256 +
            3 *
            256 +
            tempNumber[3];

        return result;
    }

    function calculateMatchingRewardAmount()
        internal
        view
        returns (uint256[4] memory)
    {
        uint64[keyLengthForEachBuy]
            memory numberIndexKey = generateNumberIndexKey(winningNumbers);

        uint256 totalAmout1 = userBuyAmountSum[issueIndex][numberIndexKey[0]];

        uint256 sumForTotalAmout2 = userBuyAmountSum[issueIndex][
            numberIndexKey[1]
        ];
        sumForTotalAmout2 = sumForTotalAmout2.add(
            userBuyAmountSum[issueIndex][numberIndexKey[2]]
        );
        sumForTotalAmout2 = sumForTotalAmout2.add(
            userBuyAmountSum[issueIndex][numberIndexKey[3]]
        );
        sumForTotalAmout2 = sumForTotalAmout2.add(
            userBuyAmountSum[issueIndex][numberIndexKey[4]]
        );

        uint256 totalAmout2 = sumForTotalAmout2.sub(totalAmout1.mul(4));

        uint256 sumForTotalAmout3 = userBuyAmountSum[issueIndex][
            numberIndexKey[5]
        ];
        sumForTotalAmout3 = sumForTotalAmout3.add(
            userBuyAmountSum[issueIndex][numberIndexKey[6]]
        );
        sumForTotalAmout3 = sumForTotalAmout3.add(
            userBuyAmountSum[issueIndex][numberIndexKey[7]]
        );
        sumForTotalAmout3 = sumForTotalAmout3.add(
            userBuyAmountSum[issueIndex][numberIndexKey[8]]
        );
        sumForTotalAmout3 = sumForTotalAmout3.add(
            userBuyAmountSum[issueIndex][numberIndexKey[9]]
        );
        sumForTotalAmout3 = sumForTotalAmout3.add(
            userBuyAmountSum[issueIndex][numberIndexKey[10]]
        );

        uint256 totalAmout3 = sumForTotalAmout3.add(totalAmout1.mul(6)).sub(
            sumForTotalAmout2.mul(3)
        );

        return [totalAmount, totalAmout1, totalAmout2, totalAmout3];
    }

    function getMatchingRewardAmount(
        uint256 _issueIndex,
        uint256 _matchingNumber
    ) public view returns (uint256) {
        return historyAmount[_issueIndex][5 - _matchingNumber];
    }

    function getUserHistory(
        address member,
        uint256 _issueIndex
    ) public view returns (uint256[] memory) {
        return userHistory[member][_issueIndex];
    }

    function getTotalRewards(
        uint256 _issueIndex
    ) public view returns (uint256) {
        require(_issueIndex <= issueIndex, "_issueIndex <= issueIndex");

        if (!drawed() && _issueIndex == issueIndex) {
            return totalAmount;
        }
        return historyAmount[_issueIndex][0];
    }

    function getRewardView(uint256 _lotteryId) public view returns (uint256) {
        uint256 _issueIndex = lotteryBuyInfo[_lotteryId].issueIndex;
        uint8[4] memory lotteryNumbers = lotteryBuyInfo[_lotteryId].numbers;
        uint8[4] memory _winningNumbers = historyNumbers[_issueIndex];
        require(_winningNumbers[0] != 0, "not drawed");

        uint256 matchingNumber = 0;
        for (uint i = 0; i < _winningNumbers.length; i++) {
            if (_winningNumbers[i] == lotteryNumbers[i]) {
                matchingNumber = matchingNumber + 1;
            }
        }
        uint256 reward = 0;
        if (matchingNumber > 1) {
            uint256 amount = lotteryBuyInfo[_lotteryId].total;
            uint256 poolAmount = getTotalRewards(_issueIndex)
                .mul(allocation[4 - matchingNumber])
                .div(100);
            reward = amount
                .mul(1e12)
                .div(getMatchingRewardAmount(_issueIndex, matchingNumber))
                .mul(poolAmount);
        }
        return reward.div(1e12);
    }

    function random(uint randNum) private view returns (uint8) {
        // Generate a random number between 1 and 100:
        uint randNonce = randNum;
        uint random = uint(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))
        ) % maxNumber;
        randNonce++;
        uint random2 = uint(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))
        ) % maxNumber;

        if (random2 == maxNumber) {
            return uint8(random2 - 1);
        }

        if (random2 == 0) {
            return 1;
        }

        return uint8(random2);
    }

    // Update admin address by the previous dev.
    function setAdmin(address _adminAddress) public onlyOwner {
        adminAddress = _adminAddress;
    }

    // Withdraw without caring about rewards. EMERGENCY ONLY.
    function adminWithdraw(uint256 _amount) public onlyOwner {
        winery.transfer(address(msg.sender), _amount);
        emit DevWithdraw(msg.sender, _amount);
    }

    // Reset treasury address for contract
    function setTreasuryAddress(address _treasuryAddress) external onlyOwner {
        treasuryAddress = _treasuryAddress;
    }

    // Set the minimum price for one ticket
    function setMinPrice(uint256 _price) external onlyOwner {
        minPrice = _price;
    }

    // Set the max number
    function setMaxNumber(uint8 _maxNumber) external onlyOwner {
        maxNumber = _maxNumber;
    }

    // Set the time for next round
    function setNextTimeDraw(uint256 _nextTime) external onlyOwner {
        nextTimeDraw = _nextTime;
    }

    function setAllocation(
        uint8 _allocation1,
        uint8 _allocation2,
        uint8 _allocation3
    ) external onlyOwner {
        _setAllocation(_allocation1, _allocation2, _allocation3);
    }

    // Set the allocation for one reward
    function _setAllocation(
        uint8 _allocation1,
        uint8 _allocation2,
        uint8 _allocation3
    ) internal {
        uint8 totalAllocation = uint8(
            _allocation1.add(
                _allocation2.add(_allocation3).add(rolloverAllocation)
            )
        );
        require(totalAllocation <= 100, "Total allocation is more than 100");
        allocation = [_allocation1, _allocation2, _allocation3];
    }
}
