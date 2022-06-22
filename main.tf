# Provider
provider "yandex" {
  # Only one of token or service_account_key_file must be specified.
  token     = var.yc_token
  #service_account_key_file = var.yc_key_file
  cloud_id  = var.yc_cloud_id
  zone      = var.yc_region

}


module "vpc" {
  source  = "hamnsk/vpc/yandex"
  version = "0.5.0"
  description = "managed by terraform"
  create_folder = length(var.yc_folder_id) > 0 ? false : true
  yc_folder_id = var.yc_folder_id
  name = local.workspace
  subnets = local.vpc_subnets[local.workspace]
}


module "news" {
  source = "./modules/instance"
  instance_count = local.news_instance_count[local.workspace]

  subnet_id     = module.vpc.subnet_ids[0]
  zone = var.yc_region
  folder_id = module.vpc.folder_id
  id_rsa_pub = var.id_rsa_pub
  #image         = "centos-7"
  image         = "ubuntu-2004-lts"
  platform_id   = "standard-v2"
  name          = "news"
  description   = "News App Demo"
  instance_role = "news,balancer"
  users         = "ubuntu"
  cores         = local.news_cores[local.workspace]
  boot_disk     = "network-ssd"
  disk_size     = local.news_disk_size[local.workspace]
  nat           = "true"
  memory        = "2"
  core_fraction = "100"
  depends_on = [
    module.vpc
  ]
}


locals {
  workspace = "stage"
  news_cores = {
    stage = 2
    prod = 2
  }
  news_disk_size = {
    stage = 20
    prod = 40
  }
  news_instance_count = {
    stage = 1
    prod = 2
  }
  vpc_subnets = {
    stage = [
      {
        "v4_cidr_blocks": [
          "10.128.0.0/24"
        ],
        "zone": var.yc_region
      }
    ]
    prod = [
      {
        zone           = "ru-central1-a"
        v4_cidr_blocks = ["10.128.0.0/24"]
      },
      {
        zone           = "ru-central1-b"
        v4_cidr_blocks = ["10.129.0.0/24"]
      },
      {
        zone           = "ru-central1-c"
        v4_cidr_blocks = ["10.130.0.0/24"]
      }
    ]
  }
}
