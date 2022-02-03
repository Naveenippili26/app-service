provider "azurerm" {
	features{}
}


resource "azurerm_resource_group" "project-rg" {		
	name = var.rg_name
	location = var.location
}

resource "azurerm_app_service_plan" "app-service-plan"{
	name	=	var.app_service_plan_name
	location	=	azurerm_resource_group.project-rg.location
	resource_group_name	=	azurerm_resource_group.project-rg.name
	kind	=	"Windows"
	reserved	=	false

	sku{
		tier	=	"Standard"
		size	=	"S1"
	}

}

resource "azurerm_app_service" "webapp" {
  name                = "${var.prefix}-appservice"
  location            = azurerm_resource_group.project-rg.location
  resource_group_name = azurerm_resource_group.project-rg.name
  app_service_plan_id = azurerm_app_service_plan.app-service-plan.id

  site_config {
    dotnet_framework_version = "v4.0"
  }
}


