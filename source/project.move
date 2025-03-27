
module MyModule::LearnToEarn {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a learning module
    struct LearningModule has store, key {
        reward: u64,         // Reward for completing the module
        completed: bool,     // Whether the module is completed
    }

    /// Function to create a new learning module with a reward.
    public fun create_module(owner: &signer, reward: u64) {
        let module = MyModule::LearnToEarn::LearningModule {
            reward,
            completed: false,
        };
        move_to(owner, module);
    }

    /// Function for users to complete the module and earn incentives.
    public fun complete_module(user: &signer, module_owner: address) acquires MyModule::LearnToEarn::LearningModule {
        let module = borrow_global_mut<MyModule::LearnToEarn::LearningModule>(module_owner);

        // Ensure that the module is not already completed
        assert!(module.completed == false, 100);

        // Mark the module as completed
        module.completed = true;

        // Transfer the reward from the module owner to the user
        let reward = coin::withdraw<AptosCoin>(module_owner, module.reward);
        coin::deposit<AptosCoin>(user, reward);
    }
}



