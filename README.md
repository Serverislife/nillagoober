# NillaGoober

`nillagoober_tv` is a [Go](https://golang.org/) project running in Azure that serves as [nillagoober](https://twitch.tv/nillagoober)'s personal hype-man. It's purpose is to post to social media when `nillagoober` goes live on Twitch and generally promote the streamer at least once a day. It currently is being purposed as a bot on Discord, but will branch to also use social media as a platform for promotion in the near future.

## Getting Started

### Discord bot command list

All commands in this list are to be preceeded by `!!`. At some point I'd like to have this to be paramaterized so it can be customized.

- `help` - Prints a message directing a user to this GitHub project for command references.
- `pepega` - Prints `pepega clap` to a Discord channel. Good for Chiddy.
- `viewers` - This command interacts with the Twitch API to gather the amount of current viewers watching the stream, and sends the number to a Discord channel.

Lots more coming soon.

### Prerequisites

- Terraform is installed
- Azure cloud shell is installed
- An Azure account (you need to put a subscription ID from your account in `main.tf`)
- `Go` is installed so that you can compile an executable

## Useful links

- [Azure](https://azure.microsoft.com/en-us/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [Terraform documentation w/ examples](https://learn.hashicorp.com/terraform?track=azure#azure)
- [How to download Go](https://golang.org/dl/)
- [Nillagoober's Twitch](https://twitch.tv/nillagoober)

## TODO

- Write more Twitch interactive functions
- Update README with Go information
- Parameterize input in `main.tf`

## Contact

- [Email](mailto:bsmreker1@gmail.com)
