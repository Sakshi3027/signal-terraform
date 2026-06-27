module "networking" {
  source      = "../../modules/networking"
  region      = var.region
  environment = "dev"
}

module "gke" {
  source       = "../../modules/gke"
  project_id   = var.project_id
  region       = var.region
  environment  = "dev"
  network      = module.networking.network_name
  subnetwork   = module.networking.subnetwork_name
  node_count   = 2
  machine_type = "e2-standard-2"
}

module "postgres" {
  source      = "../../modules/postgres"
  region      = var.region
  environment = "dev"
  tier        = "db-f1-micro"
  network_id  = module.networking.network_id
  db_password = var.db_password
}
