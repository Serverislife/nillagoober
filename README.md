# Nillagoober_tv

`nillagoober_tv` is a Python project running in Azure that serves as [nillaboober](https://twitch.tv/nillagoober)'s personal hype-man. It's purpose is to post to social media when `nillagoober` goes live on Twitch and generally promote the streamer at least once a day. The future of this project is to parameterize the name of the streamer to promote and monitor, removing hard-coded Twitch names.

## Getting Started

### Prerequisites

- Terraform is installed
- Azure cloud shell is installed
- An Azure account (you need to put a subscription ID from your account in `main.tf`)

To get started promoting a Twitch streamer:

- Clone this repository with `git clone <url>`
- Use Terraform to provision the infrastructure (currently limited to Azure, free though)
  - Initialize the Terraform project `terraform init`. This command will create a `.terraform` directory using considerations from `main.tf`. This directory is included in the `.gitignore`.
  - Generate a plan based on the contents of `main.tf`. Simply run `terraform plan`. **Optional**: run `terraform apply` with the `-out` flag to save the plan to a file.
  - To build the server using the plan created in the last step, run `terraform apply` (use the `-plan` flag if you saved the plan to a file).

## Useful links

- [Terraform documentation w/ examples](https://learn.hashicorp.com/terraform?track=azure#azure)
- [Azure](https://azure.microsoft.com/en-us/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

## TODO

- Write out the Python project
- Update README with Python information
- Parameterize input in `main.tf`

## Contact

- [Email](mailto:bsmreker1@gmail.com)
