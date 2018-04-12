### Follow these instructions to release a new version of hydra-head, including the contained gems: hydra-core and hydra-access-controls.

1. In your local repo, on master, bump version number in [HYDRA_VERSION](https://github.com/samvera/hydra-head/blob/master/HYDRA_VERSION) (but don't add, commit or push the change, the Rake release task will do it). 
1. Create a [GitHub release](https://github.com/samvera/hydra-head/releases/new) and include changes in the version (which can usually be pulled from commit messages). If steps are required to upgrade to the new version, make sure to include these changes. (See [an example](https://github.com/samvera/hydra-head/releases/tag/v9.2.2).)
1. Release the gem to rubygems.org: `rake all:release`
  * If this is your first time pushing to rubygems.org, you will be prompted for your rubygems.org credentials, in which case do the following: `gem push; rake all:release`
1. If needed, push the new commit created in the previous step: `git push`
1. Send a release message to [samvera-tech](mailto:samvera-tech@googlegroups.com), [samvera-community](mailto:hydra-community@googlegroups.com), and [samvera-releases](mailto:samvera-releases@googlegroups.com) describing the changes (which you can copy from the GitHub release).
