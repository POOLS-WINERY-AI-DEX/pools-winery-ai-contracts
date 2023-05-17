/**
 *Submitted for verification at BscScan.com on 2023-05-15
 */

/**
 *Submitted for verification at BscScan.com on 2022-06-22
 */

/**
 *Submitted for verification at BscScan.com on 2022-04-20
 */

/**
 *Submitted for verification at BscScan.com on 2022-04-04
 */

// File: @openzeppelin/contracts/utils/Address.sol

// OpenZeppelin Contracts (last updated v4.5.0) (utils/Address.sol)

pragma solidity ^0.8.1;

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
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
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

        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
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

        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return verifyCallResult(success, returndata, errorMessage);
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

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
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

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

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

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address owner,
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
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
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

// File: @openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol

// OpenZeppelin Contracts v4.4.1 (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.0;

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.approve.selector, spender, value)
        );
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(
                oldAllowance >= value,
                "SafeERC20: decreased allowance below zero"
            );
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(
                token,
                abi.encodeWithSelector(
                    token.approve.selector,
                    spender,
                    newAllowance
                )
            );
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(
            data,
            "SafeERC20: low-level call failed"
        );
        if (returndata.length > 0) {
            // Return data is optional
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}

// File: @openzeppelin/contracts/utils/introspection/IERC165.sol

// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721.sol

// OpenZeppelin Contracts v4.4.1 (token/ERC721/IERC721.sol)

pragma solidity ^0.8.0;

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(
        uint256 tokenId
    ) external view returns (address operator);

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
}

// File: @openzeppelin/contracts/security/ReentrancyGuard.sol

// OpenZeppelin Contracts v4.4.1 (security/ReentrancyGuard.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

// File: @openzeppelin/contracts/utils/Context.sol

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/security/Pausable.sol

// OpenZeppelin Contracts v4.4.1 (security/Pausable.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
abstract contract Pausable is Context {
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by `account`.
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state.
     */
    constructor() {
        _paused = false;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view virtual returns (bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    modifier whenNotPaused() {
        require(!paused(), "Pausable: paused");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    modifier whenPaused() {
        require(paused(), "Pausable: not paused");
        _;
    }

    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function _pause() internal virtual whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function _unpause() internal virtual whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)

pragma solidity ^0.8.0;

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
    constructor() {
        _transferOwnership(_msgSender());
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
        _transferOwnership(address(0));
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
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: contracts/Market.sol

pragma solidity 0.8.4;

interface ISwapFeeRewardWithRB {
    function accrueRBFromMarket(
        address account,
        address fromToken,
        uint256 amount
    ) external;
}

interface ISmartChefMarket {
    function updateStakedTokens(address _user, uint256 amount) external;
}

contract PoolsWineryAIMarket is ReentrancyGuard, Ownable, Pausable {
    using SafeERC20 for IERC20;

    enum Side {
        Sell,
        Buy
    }
    enum OfferStatus {
        Open,
        Accepted,
        Cancelled
    }

    struct RoyaltyStr {
        uint32 rate;
        address receiver;
        bool enable;
    }

    uint256 constant MAX_DEFAULT_FEE = 1000; // max fee 10% (base 10000)
    uint256 public defaultFee = 100; //in base 10000 1%
    uint8 public maxUserTokenOnSellToReward = 3; //max count sell offers of nftForAccrualRB on which Rb accrual
    uint256 rewardDistributionSeller = 50; //Distribution reward between seller and buyer. Base 100
    address public treasuryAddress;
    ISwapFeeRewardWithRB feeRewardRB;
    ISmartChefMarket smartChefMarket;
    bool feeRewardRBIsEnabled = false; // Enable/disable accrue RB reward for trade NFT tokens from nftForAccrualRB list
    bool placementRewardEnabled = false; //Enable rewards for place NFT tokens on market

    Offer[] public offers;
    mapping(IERC721 => mapping(uint256 => uint256)) public tokenSellOffers; // nft => tokenId => id
    mapping(address => mapping(IERC721 => mapping(uint256 => uint256)))
        public userBuyOffers; // user => nft => tokenId => id
    mapping(address => bool) public nftBlacklist; //add tokens on blackList
    mapping(address => bool) public nftForAccrualRB; //add tokens on which RobiBoost is accrual
    mapping(address => bool) public dealTokensWhitelist;
    mapping(address => uint256) public userFee; //User trade fee. if Zero - fee by default
    mapping(address => uint256) public tokensCount; //User`s number of tokens on sale: user => count
    mapping(address => RoyaltyStr) public royalty; //Royalty for NFT creator. NFTToken => royalty (base 10000)

    struct Offer {
        uint256 tokenId;
        uint256 price;
        IERC20 dealToken;
        IERC721 nft;
        address user;
        address acceptUser;
        OfferStatus status;
        Side side;
    }

    event NewOffer(
        address indexed user,
        IERC721 indexed nft,
        uint256 indexed tokenId,
        address dealToken,
        uint256 price,
        Side side,
        uint256 id
    );

    event CancelOffer(uint256 indexed id);
    event AcceptOffer(uint256 indexed id, address indexed user, uint256 price);
    event NewTreasuryAddress(address _treasuryAddress);
    event NFTBlackListUpdate(address nft, bool state);
    event NFTAccrualListUpdate(address nft, bool state);
    event DealTokensWhiteListUpdate(address token, bool whiteListed);
    event NewUserFee(address user, uint256 fee);
    event SetRoyalty(
        address nftAddress,
        address royaltyReceiver,
        uint32 rate,
        bool enable
    );

    constructor(address _treasuryAddress) {
        //NFT-01
        require(_treasuryAddress != address(0), "Address cant be zero");
        treasuryAddress = _treasuryAddress;
        feeRewardRB = ISwapFeeRewardWithRB(address(0));
        feeRewardRBIsEnabled = false;
        // take id(0) as placeholder
        offers.push(
            Offer({
                tokenId: 0,
                price: 0,
                nft: IERC721(address(0)),
                dealToken: IERC20(address(0)),
                user: address(0),
                acceptUser: address(0),
                status: OfferStatus.Cancelled,
                side: Side.Buy
            })
        );
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function enableRBFeeReward() public onlyOwner {
        feeRewardRBIsEnabled = true;
    }

    function disableRBFeeReward() public onlyOwner {
        feeRewardRBIsEnabled = false;
    }

    function enablePlacementReward() public onlyOwner {
        placementRewardEnabled = true;
    }

    function disablePlacementReward() public onlyOwner {
        placementRewardEnabled = false;
    }

    function setTreasuryAddress(address _treasuryAddress) public onlyOwner {
        //NFT-01
        require(_treasuryAddress != address(0), "Address cant be zero");
        treasuryAddress = _treasuryAddress;
        emit NewTreasuryAddress(_treasuryAddress);
    }

    function setRewardDistributionSeller(
        uint256 _rewardDistributionSeller
    ) public onlyOwner {
        require(
            _rewardDistributionSeller <= 100,
            "Incorrect value Must be equal to or greater than 100"
        );
        rewardDistributionSeller = _rewardDistributionSeller;
    }

    function setRoyalty(
        address nftAddress,
        address royaltyReceiver,
        uint32 rate,
        bool enable
    ) public onlyOwner {
        require(nftAddress != address(0), "Address cant be zero");
        require(royaltyReceiver != address(0), "Address cant be zero");
        require(rate < 10000, "Rate must be less than 10000");
        royalty[nftAddress].receiver = royaltyReceiver;
        royalty[nftAddress].rate = rate;
        royalty[nftAddress].enable = enable;
        emit SetRoyalty(nftAddress, royaltyReceiver, rate, enable);
    }

    function addBlackListNFT(address[] calldata nfts) public onlyOwner {
        for (uint256 i = 0; i < nfts.length; i++) {
            nftBlacklist[nfts[i]] = true;
            emit NFTBlackListUpdate(nfts[i], true);
        }
    }

    function delBlackListNFT(address[] calldata nfts) public onlyOwner {
        for (uint256 i = 0; i < nfts.length; i++) {
            delete nftBlacklist[nfts[i]];
            emit NFTBlackListUpdate(nfts[i], false);
        }
    }

    function addWhiteListDealTokens(
        address[] calldata _tokens
    ) public onlyOwner {
        for (uint256 i = 0; i < _tokens.length; i++) {
            require(_tokens[i] != address(0), "Address cant be 0");
            dealTokensWhitelist[_tokens[i]] = true;
            emit DealTokensWhiteListUpdate(_tokens[i], true);
        }
    }

    function delWhiteListDealTokens(
        address[] calldata _tokens
    ) public onlyOwner {
        for (uint256 i = 0; i < _tokens.length; i++) {
            delete dealTokensWhitelist[_tokens[i]];
            emit DealTokensWhiteListUpdate(_tokens[i], false);
        }
    }

    function addNftForAccrualRB(address _nft) public onlyOwner {
        require(_nft != address(0), "Address cant be zero");
        nftForAccrualRB[_nft] = true;
        emit NFTAccrualListUpdate(_nft, true);
    }

    function delNftForAccrualRB(address _nft) public onlyOwner {
        require(_nft != address(0), "Address cant be zero");
        delete nftForAccrualRB[_nft];
        emit NFTAccrualListUpdate(_nft, false);
    }

    function setUserFee(address user, uint256 fee) public onlyOwner {
        userFee[user] = fee;
        emit NewUserFee(user, fee);
    }

    function setDefaultFee(uint256 _newFee) public onlyOwner {
        require(
            _newFee <= MAX_DEFAULT_FEE,
            "New fee must be less than or equal to max fee"
        );
        defaultFee = _newFee;
    }

    function SetMaxUserTokenOnSellToReward(uint8 newCount) public onlyOwner {
        maxUserTokenOnSellToReward = newCount;
    }

    function setSmartChefMarket(
        ISmartChefMarket _smartChefMarket
    ) public onlyOwner {
        require(address(_smartChefMarket) != address(0), "Address cant be 0");
        smartChefMarket = _smartChefMarket;
    }

    function setFeeRewardRB(
        ISwapFeeRewardWithRB _feeRewardRB
    ) public onlyOwner {
        require(address(_feeRewardRB) != address(0), "Address cant be 0");
        feeRewardRB = _feeRewardRB;
    }

    // user functions

    function offer(
        Side side,
        address dealToken,
        IERC721 nft,
        uint256 tokenId,
        uint256 price
    )
        public
        nonReentrant
        whenNotPaused
        _nftAllowed(nft)
        _validDealToken(dealToken)
        notContract
    {
        if (side == Side.Buy) {
            _offerBuy(nft, tokenId, price, dealToken);
        } else if (side == Side.Sell) {
            _offerSell(nft, tokenId, price, dealToken);
        } else {
            revert("Not supported");
        }
    }

    function accept(
        uint256 id
    )
        public
        nonReentrant
        _offerExists(id)
        _offerOpen(id)
        _notBlackListed(id)
        whenNotPaused
        notContract
    {
        if (offers[id].side == Side.Buy) {
            _acceptBuy(id);
        } else {
            _acceptSell(id);
        }
    }

    function cancel(
        uint256 id
    )
        public
        nonReentrant
        _offerExists(id)
        _offerOpen(id)
        _offerOwner(id)
        whenNotPaused
    {
        if (offers[id].side == Side.Buy) {
            _cancelBuy(id);
        } else {
            _cancelSell(id);
        }
    }

    function multiCancel(uint256[] calldata ids) public notContract {
        for (uint256 i = 0; i < ids.length; i++) {
            cancel(ids[i]);
        }
    }

    function getOffersLength() public view returns (uint256) {
        return offers.length;
    }

    //increase: true - increase token to accrue rewards; false - decrease token from
    function placementRewardQualifier(
        bool increase,
        address user,
        address nftToken
    ) internal {
        //Check if nft token in nftForAccrualRB list and accrue reward enable
        if (!nftForAccrualRB[nftToken] || !placementRewardEnabled) return;

        if (increase) {
            tokensCount[user]++;
        } else {
            tokensCount[user] = tokensCount[user] > 0
                ? tokensCount[user] - 1
                : 0;
        }
        if (tokensCount[user] > maxUserTokenOnSellToReward) return;

        uint256 stakedAmount = tokensCount[user] >= maxUserTokenOnSellToReward
            ? maxUserTokenOnSellToReward
            : tokensCount[user];
        smartChefMarket.updateStakedTokens(user, stakedAmount);
    }

    function _offerSell(
        IERC721 nft,
        uint256 tokenId,
        uint256 price,
        address dealToken
    ) internal {
        require(msg.value == 0, "Seller should not pay");
        require(price > 0, "price > 0");
        offers.push(
            Offer({
                tokenId: tokenId,
                price: price,
                dealToken: IERC20(dealToken),
                nft: nft,
                user: msg.sender,
                acceptUser: address(0),
                status: OfferStatus.Open,
                side: Side.Sell
            })
        );

        uint256 id = offers.length - 1;
        emit NewOffer(
            msg.sender,
            nft,
            tokenId,
            dealToken,
            price,
            Side.Sell,
            id
        );

        require(getTokenOwner(id) == msg.sender, "sender should own the token");
        require(isTokenApproved(id, msg.sender), "token is not approved");

        if (tokenSellOffers[nft][tokenId] > 0) {
            _closeSellOfferFor(nft, tokenId);
        } else {
            placementRewardQualifier(true, msg.sender, address(nft));
        }
        tokenSellOffers[nft][tokenId] = id;
    }

    function _offerBuy(
        IERC721 nft,
        uint256 tokenId,
        uint256 price,
        address dealToken
    ) internal {
        IERC20(dealToken).safeTransferFrom(msg.sender, address(this), price);
        require(price > 0, "buyer should pay");
        offers.push(
            Offer({
                tokenId: tokenId,
                price: price,
                dealToken: IERC20(dealToken),
                nft: nft,
                user: msg.sender,
                acceptUser: address(0),
                status: OfferStatus.Open,
                side: Side.Buy
            })
        );
        uint256 id = offers.length - 1;
        emit NewOffer(msg.sender, nft, tokenId, dealToken, price, Side.Buy, id);
        _closeUserBuyOffer(userBuyOffers[msg.sender][nft][tokenId]);
        userBuyOffers[msg.sender][nft][tokenId] = id;
    }

    function _acceptBuy(uint256 id) internal {
        // caller is seller
        Offer storage _offer = offers[id];
        require(msg.value == 0, "seller should not pay");

        require(getTokenOwner(id) == msg.sender, "only owner can call");
        require(isTokenApproved(id, msg.sender), "token is not approved");
        _offer.status = OfferStatus.Accepted;
        _offer.acceptUser = msg.sender;

        _offer.nft.safeTransferFrom(msg.sender, _offer.user, _offer.tokenId);
        _distributePayment(_offer);

        emit AcceptOffer(id, msg.sender, _offer.price);
        _unlinkBuyOffer(_offer);
        if (tokenSellOffers[_offer.nft][_offer.tokenId] > 0) {
            _closeSellOfferFor(_offer.nft, _offer.tokenId);
            //NFT-03
            placementRewardQualifier(false, msg.sender, address(_offer.nft));
        }
    }

    function _acceptSell(uint256 id) internal {
        // caller is buyer
        Offer storage _offer = offers[id];

        if (
            getTokenOwner(id) != _offer.user ||
            isTokenApproved(id, _offer.user) == false
        ) {
            _cancelSell(id);
            return;
        }

        _offer.status = OfferStatus.Accepted;
        _offer.acceptUser = msg.sender;
        _unlinkSellOffer(_offer);

        _offer.dealToken.safeTransferFrom(
            msg.sender,
            address(this),
            _offer.price
        );
        _distributePayment(_offer);
        _offer.nft.safeTransferFrom(_offer.user, msg.sender, _offer.tokenId);
        emit AcceptOffer(id, msg.sender, _offer.price);
    }

    function _cancelSell(uint256 id) internal {
        Offer storage _offer = offers[id];
        require(_offer.status == OfferStatus.Open, "Offer was cancelled");
        _offer.status = OfferStatus.Cancelled;
        emit CancelOffer(id);
        _unlinkSellOffer(_offer);
    }

    function _cancelBuy(uint256 id) internal {
        Offer storage _offer = offers[id];
        require(_offer.status == OfferStatus.Open, "Offer was cancelled");
        _offer.status = OfferStatus.Cancelled;
        _transfer(msg.sender, _offer.price, _offer.dealToken);
        emit CancelOffer(id);
        _unlinkBuyOffer(_offer);
    }

    // modifiers
    modifier _validDealToken(address _token) {
        require(dealTokensWhitelist[_token], "Deal token not available");
        _;
    }
    modifier _offerExists(uint256 id) {
        require(id > 0 && id < offers.length, "offer does not exist");
        _;
    }

    modifier _offerOpen(uint256 id) {
        require(offers[id].status == OfferStatus.Open, "offer should be open");
        _;
    }

    modifier _offerOwner(uint256 id) {
        require(offers[id].user == msg.sender, "call should own the offer");
        _;
    }

    modifier _notBlackListed(uint256 id) {
        Offer storage _offer = offers[id];
        require(!nftBlacklist[address(_offer.nft)], "NFT in black list");
        _;
    }

    modifier _nftAllowed(IERC721 nft) {
        require(!nftBlacklist[address(nft)], "NFT in black list");
        _;
    }

    modifier notContract() {
        require(!_isContract(msg.sender), "Contract not allowed");
        require(msg.sender == tx.origin, "Proxy contract not allowed");
        _;
    }

    // internal functions
    function _transfer(address to, uint256 amount, IERC20 _dealToken) internal {
        require(
            amount > 0 && to != address(0),
            "Wrong amount or dest on transfer"
        );
        _dealToken.safeTransfer(to, amount);
    }

    function _distributePayment(Offer memory _offer) internal {
        (address seller, address buyer) = _offer.side == Side.Sell
            ? (_offer.user, _offer.acceptUser)
            : (_offer.acceptUser, _offer.user);
        uint256 feeRate = userFee[seller] == 0 ? defaultFee : userFee[seller];
        uint256 fee = (_offer.price * feeRate) / 10000;
        uint256 royaltyFee = 0;
        if (royalty[address(_offer.nft)].enable) {
            royaltyFee =
                (_offer.price * royalty[address(_offer.nft)].rate) /
                10000;
            _transfer(
                royalty[address(_offer.nft)].receiver,
                royaltyFee,
                _offer.dealToken
            );
        }
        _transfer(treasuryAddress, fee, _offer.dealToken);
        _transfer(seller, _offer.price - fee - royaltyFee, _offer.dealToken);
        if (feeRewardRBIsEnabled && nftForAccrualRB[address(_offer.nft)]) {
            feeRewardRB.accrueRBFromMarket(
                seller,
                address(_offer.dealToken),
                (fee * rewardDistributionSeller) / 100
            );
            feeRewardRB.accrueRBFromMarket(
                buyer,
                address(_offer.dealToken),
                (fee * (100 - rewardDistributionSeller)) / 100
            );
        }
    }

    function _closeSellOfferFor(IERC721 nft, uint256 tokenId) internal {
        uint256 id = tokenSellOffers[nft][tokenId];
        if (id == 0) return;

        // closes old open sell offer
        Offer storage _offer = offers[id];
        _offer.status = OfferStatus.Cancelled;
        tokenSellOffers[_offer.nft][_offer.tokenId] = 0;
        emit CancelOffer(id);
    }

    function _closeUserBuyOffer(uint256 id) internal {
        Offer storage _offer = offers[id];
        if (
            id > 0 &&
            _offer.status == OfferStatus.Open &&
            _offer.side == Side.Buy
        ) {
            _offer.status = OfferStatus.Cancelled;
            _transfer(_offer.user, _offer.price, _offer.dealToken);
            _unlinkBuyOffer(_offer);
            emit CancelOffer(id);
        }
    }

    function _unlinkBuyOffer(Offer storage o) internal {
        userBuyOffers[o.user][o.nft][o.tokenId] = 0;
    }

    function _unlinkSellOffer(Offer storage o) internal {
        placementRewardQualifier(false, o.user, address(o.nft));
        tokenSellOffers[o.nft][o.tokenId] = 0;
    }

    // helpers

    function isValidSell(uint256 id) public view returns (bool) {
        if (id >= offers.length) {
            return false;
        }

        Offer storage _offer = offers[id];
        // try to not throw exception
        return
            _offer.status == OfferStatus.Open &&
            _offer.side == Side.Sell &&
            isTokenApproved(id, _offer.user) &&
            (_offer.nft.ownerOf(_offer.tokenId) == _offer.user);
    }

    function isTokenApproved(
        uint256 id,
        address owner
    ) public view returns (bool) {
        Offer storage _offer = offers[id];
        return
            _offer.nft.getApproved(_offer.tokenId) == address(this) ||
            _offer.nft.isApprovedForAll(owner, address(this));
    }

    function getTokenOwner(uint256 id) public view returns (address) {
        Offer storage _offer = offers[id];
        return _offer.nft.ownerOf(_offer.tokenId);
    }

    function _isContract(address _addr) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(_addr)
        }
        return size > 0;
    }
}
