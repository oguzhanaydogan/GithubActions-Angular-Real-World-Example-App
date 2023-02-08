variable "rg_name" {
default = "wordpress-mysql" 
}
variable "location" {
    default = "East US"
  
}
variable "acr_name" {
    default = "mysqlfortest"
}
variable "service_plan_name" {
    default = "mysql-wordpress"
}
variable "webapp_name" {
    default = "mysqldatabase-wordpress"
}
