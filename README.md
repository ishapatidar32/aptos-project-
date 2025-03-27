# LearnToEarn Module

## Overview
The `LearnToEarn` module provides a simple framework where users can complete learning modules to earn rewards. This module utilizes the Aptos blockchain and its native `AptosCoin` as incentives for users who complete a learning module.

## Features
- **Create Learning Modules:** Users can create a learning module with a specified reward.
- **Complete Modules:** Other users can complete a module and claim the associated reward.
- **Secure Transactions:** Ensures that rewards are only granted once per module completion.

## Module Structure

### LearningModule Struct
```move
struct LearningModule has store, key {
    reward: u64,         // Reward for completing the module
    completed: bool,     // Whether the module is completed
}
```
This struct holds the reward amount and completion status of the module.

## Functions

### `create_module(owner: &signer, reward: u64)`
Creates a new learning module with a specified reward.

#### Parameters:
- `owner`: The signer who creates the module.
- `reward`: The amount of `AptosCoin` to be rewarded upon completion.

### `complete_module(user: &signer, module_owner: address)`
Allows a user to complete a module and claim the associated reward.

#### Parameters:
- `user`: The signer who completes the module.
- `module_owner`: The address of the module creator.

#### Process:
1. Ensures that the module has not been completed already.
2. Marks the module as completed.
3. Transfers the reward from the module owner to the user.

## Security Considerations
- The `assert!` function ensures that a module cannot be completed more than once.
- Uses the `coin::withdraw` and `coin::deposit` functions to securely transfer funds.
- Requires `acquires LearningModule` to ensure that only authorized functions can modify the module state.

## Example Usage

### Creating a Module
```move
let owner = signer::address_of(signer);
create_module(&signer, 100);
```

### Completing a Module
```move
complete_module(&signer, owner_address);
```

This will transfer 100 `AptosCoin` from the module owner to the user completing the module.
