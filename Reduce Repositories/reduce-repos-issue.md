### Why
We are suffering from the maximum amount of private repositories on GitHub, and one major reason is that iOS team has occupied lots of private repositories.
Therefore, we have to rearrange them, and figure out a way to keep current projects working because of these dependencies.

### Solution
Since we manage the dependencies of each project with [CocoaPods](https://cocoapods.org) and there are several private Pod components on GitHub,
one possible solution is that we combine all the private Pod components into one big project as well as one private repository.
Furthermore, we point to the `master` branch directly instead of a specific tag inside the `Podfile`, and we're able to update a certain component right after we approve its PR and merge the PR into the `master` branch.
As a result, it simplifies the releasing process of each component.
However, since we don't want to reveal the implementation details of our private SDK, the main problem of this solution is releasing a new version of SDK with the correct components.
In current SDK releasing process, we generate the corresponding `.framework` files for each SDK kit with [Carthage](https://github.com/Carthage/Carthage).
Therefore, we can also take this advantage to generate the `.framework` for each component, because not only does Carthage support building multiple targets inside one project but it's able to build the component from a branch instead of tags as well.
Nevertheless, there is one downside with Carthage, which is it doesn't support to build one specific target within one project.
Instead, it will build all of the targets inside one project.
Consequently, we will probably suffer from long Carthage building time because of this situation.
However, it only happens when we try to release a new version of our private SDK, so it shouldn't be a huge problem.

### Implementation

### Result
