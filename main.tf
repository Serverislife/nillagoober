# Configure the Microsoft Azure Provider
provider "azurerm" {
    subscription_id = "6fbc4b5d-b5eb-42c1-974d-a5d2bc5d64fd"
    tenant_id       = "2baef15b-b8de-423f-9d8a-46f3686d8848"

}

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "nillagoober_tf_rg" {
    name     = "nillagoober_rg"
    location = "westus"

tags = {
        environment = "Nillagoober Dev"
    
}

}

# Create virtual network
resource "azurerm_virtual_network" "nillagoober_virt_net" {
    name                = "nillagoober_vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "westus"
    resource_group_name = azurerm_resource_group.nillagoober_tf_rg.name

tags = {
        environment = "Nillagoober Dev"
    
}

}

# Create subnet
resource "azurerm_subnet" "nillagoober_tf_subnet" {
    name                 = "nillagoober_subnet"
    resource_group_name  = azurerm_resource_group.nillagoober_tf_rg.name
    virtual_network_name = azurerm_virtual_network.nillagoober_virt_net.name
    address_prefix       = "10.0.1.0/24"

}

# Create public IPs
resource "azurerm_public_ip" "nillagoober_tf_pub_ip" {
    name                         = "nillagoober_public_ip"
    location                     = "westus"
    resource_group_name          = azurerm_resource_group.nillagoober_tf_rg.name
    allocation_method            = "Dynamic"

tags = {
        environment = "Nillagoober Dev"
    
}

}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nillagoober_tf_nsg" {
    name                = "nillagoober_nsg"
    location            = "westus"
    resource_group_name = azurerm_resource_group.nillagoober_tf_rg.name
    
security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    
}

tags = {
        environment = "Nillagoober Dev"
    
}

}

# Create network interface
resource "azurerm_network_interface" "nillagoober_tf_nic" {
    name                      = "nillagoober_nic"
    location                  = "westus"
    resource_group_name       = azurerm_resource_group.nillagoober_tf_rg.name
    network_security_group_id = azurerm_network_security_group.nillagoober_tf_nsg.id

ip_configuration {
        name                          = "nillagoober_nic_config"
        subnet_id                     = azurerm_subnet.nillagoober_tf_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.nillagoober_tf_pub_ip.id
    
}

tags = {
        environment = "Nillagoober Dev"
    
}

}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.nillagoober_tf_rg.name
    
}
    
    byte_length = 8

}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "nillagoober_storage_acc" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.nillagoober_tf_rg.name
    location                    = "westus"
    account_tier                = "Standard"
    account_replication_type    = "LRS"

tags = {
        environment = "Nillagoober Dev"
    
}

}

# Create virtual machine
resource "azurerm_virtual_machine" "nillagoober_vm" {
    name                  = "nillagoob_prime"
    location              = "westus"
    resource_group_name   = azurerm_resource_group.nillagoober_tf_rg.name
    network_interface_ids = [azurerm_network_interface.nillagoober_tf_nic.id]
    vm_size               = "Standard_DS1_v2"

storage_os_disk {
        name              = "OsDisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    
}

storage_image_reference {
        publisher = "OpenLogic"
        offer     = "CentOS"
        sku       = "7.5"
        version   = "latest"
    
}

os_profile {
        computer_name  = "nillagoob"
        admin_username = "azroot"
    
}

os_profile_linux_config {
        disable_password_authentication = true
ssh_keys {
            path     = "/home/azroot/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDg9L8FqM+j30y7NGrY05/V8c4e9WfVFVrWn3WtLTxfZ5vgAFVm8OgnsEWMQ3gZgVQDUpGqwIV50nth3WL2LQR6/LGZJwdpu2Nr8g03Byrid/4G1D2uQqSH7AJqmMtnVukYtha5qUvyjYYULeHlsUIY92apRyoc9chY/6mWMNu+uNF8VXxLSO5ujBDjwIE0D3RXx81/TtfJiefgI3k9B0tWAjcXJPL5SgXWE1xi/PJHFRuB7mJShfLE+ZJOxF8WMJwNkUJv5BOOGayXUuxuC/+N5Ggy93EfQN7EBFuVwSz9A353CGFz733NklDpbrsQSl98FXH99slEupVT03xf3Jth b0s00dg@yeeticusprime"
        
}
    
}

}

