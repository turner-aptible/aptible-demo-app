### LOCALS ###

locals {
  current_timestamp = timestamp()
  current_day       = formatdate("YYYY-MM-DD", local.current_timestamp)
}

### DEMO ENV ###

resource "aptible_environment" "demo_env" {
  handle   = "demo_app"
  stack_id = data.aptible_stack.demo_env.stack_id
  # Uncomment the next line if you'd like to specify the org_id
  org_id = var.org_id
}

### DEMO APP ###

resource "aptible_app" "demo_app" {
  env_id = aptible_environment.demo_env.env_id
  handle = "demo_app_${local.current_day}"
  config = {
    "APTIBLE_DOCKER_IMAGE" = "quay.io/aptible/deploy-demo-app"
    "DATABASE_URL"         = aptible_database.example_postgres.default_connection_url
    "REDIS_URL"            = aptible_database.example_redis.default_connection_url
  }
  service {
    process_type           = "web"
    container_count        = 2
    container_memory_limit = 512
  }
  service {
    process_type           = "background"
    container_count        = 0
    container_memory_limit = 512
  }
  # https://www.aptible.com/documentation/deploy/tutorials/deploy-demo-app.html#run-database-migrations
  # This is a one-time execution at application creation for demo purposes.
  # If you need to run migrations on each app release, you should use a before_release command
  # https://www.aptible.com/documentation/deploy/reference/apps/aptible-yml.html#before-release
  provisioner "local-exec" {
    command = "aptible ssh --app '${aptible_app.demo_app.handle}' python migrations.py"
  }
}

### DEMO ENDPOINT ###

resource "aptible_endpoint" "demo_endpoint" {
  env_id         = aptible_environment.demo_env.env_id
  process_type   = "web"
  resource_id    = aptible_app.demo_app.app_id
  default_domain = true
  endpoint_type  = "https"
  internal       = false
  platform       = "alb"
  container_port = 5000
  resource_type  = "app"
}

### APTIBLE DATABASES ###

resource "aptible_database" "example_redis" {
  env_id         = aptible_environment.demo_env.env_id
  handle         = "example_redis_${local.current_day}"
  database_type  = "redis"
  container_size = 512
  disk_size      = 10
}

resource "aptible_database" "example_postgres" {
  env_id         = aptible_environment.demo_env.env_id
  handle         = "example_postgres_${local.current_day}"
  database_type  = "postgresql"
  container_size = 512
  disk_size      = 10
}