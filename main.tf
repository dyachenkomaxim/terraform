version: '3.9'

services:
  my-wordpress:
    image: wordpress
    ports:
      - "80:8080"
  my-mysql:
    image: mysql
    ports:
      - "3306:33060"
    environment: 
        MYSQL_ROOT_PASSWORD: 12345678
    volumes:
      - db-data:/var/lib/mysql
 
volumes:
  db-data:


resource "azurerm_linux_virtual_machine" "testvm" { 
name 					= "testvm"
resource_group_name 	= "testrg"
size 					= "Standart_D4s_v3"
admin_username 			= "adminuser"
location 				= azurerm_resource_group.example.location
network_interface_ids = [
	azurerm_network_interface.testvm.id
]

os_disk {
caching 			 = "ReadWrite"
storage_account_type = "Standard_LRS"
}

source_image_reference {
publisher 	= "Canonical"
offer 		= "0001-com-ubuntu-server-focal"
sku 		= "20_04-lts"
version 	= "latest"
	}
}

variable "image" {
	type = string
	default = "0001-com-ubuntu-server-focal"
	description = "image name"
}



resource "azurerm_network_interface" "testvm" {
	location 						= azurerm_resource_group.example.location
	name 	 						= "testvm"
	resource_group_name 			= "testrg"
	enable_accelerated_networking   = false
	enable_ip_forwarding = false
	
	ip_configuration {
		name 							= "internal"
		private_ip_address_allocation   = "Dynamic"
		private_ip_address_version 		= "IPv4"
		subnet_id 						= "${azurerm_subnet.test.id}"
	}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}


resource "azurerm_subnet" "test" {
  name                 = "subnetid"
  resource_group_name  = "testrg"
  virtual_network_name = "testvm"
  
} 

terraform {
	required_version = ">1.1.6"
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version = "~> 3.0.2"
		}
	}
}

provider "azurerm" {
  features {}
}


11111
terraform {
  required_providers {
      virtualbox = {
        source = "terra-farm/virtualbox"
        version = "0.2.2-alpha.1"
      }
  }
}

resource "virtualbox_vm" "cp" {
  count   = 3
  name    = format("cp%02d", count.index + 1)
  image   = "https://vagrantcloud.com/geerlingguy/boxes/ubuntu1804/versions/1.0.4/providers/virtualbox.box"
  cpus    = 2
  memory = "2.0 gib"
  user_data = "test"
  network_adapter {
      type = "bridged"
      host_interface = "en6: USB 10/100/1000 LAN"
  }
}

resource "virtualbox_vm" "worker" {
  count = 3
  name = format("worker%02d", count.index + 1)
    image   = "https://vagrantcloud.com/geerlingguy/boxes/ubuntu1804/versions/1.0.4/providers/virtualbox.box"
  cpus    = 2
  memory = "2.0 gib"
  user_data = "test"
  network_adapter {
      type = "bridged"
      host_interface = "en6: USB 10/100/1000 LAN"
  }
}


