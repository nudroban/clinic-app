# Clinic App

This project is a small Rails application that uses PostgreSQL as its database. A `docker-compose.yml` file is provided to start a local PostgreSQL container.

## Prerequisites

1. **Docker** – Install Docker Desktop or Docker Engine for your operating system. Official instructions are available at <https://docs.docker.com/get-docker/>.
2. **Ruby 3.1.0** – Required when running the Rails server locally. After installing Ruby, run `bundle install` to install the gems listed in `Gemfile`.

No additional JavaScript tooling (Node or Yarn) is required because the app relies on `importmap-rails`.

## Setup

1. Clone the repository and change into the project directory.
2. Edit `config/database.yml` if you want to use different database credentials or ports. By default the app expects the PostgreSQL container to expose port `15432` and uses `test_user`/`qwerty` as credentials.
3. Start the database container:

   ```bash
   docker-compose up
   ```

   The first run downloads the PostgreSQL image and stores data under `./database/pgdata`.
4. Create and seed the database after the container is up:

   ```bash
   bin/rails db:create
   bin/rails db:seed
   ```

   Alternatively, running `bin/rails db:reset` will recreate the database and load the seeds in one command.
5. Start the Rails server with:

   ```bash
   bin/rails server
   ```

Open <http://localhost:3000> in your browser to access the application.
For login patient use phones ```0501234561 0507387966 0509876543 0501234560``` password: ```pssword```

For login doctors use phones ```0661234564 0661234562 0661234561 0661234563``` password: ```pssword```

Open <http://localhost:3000/admin/login> in browser to login admin
Enter phone: ```0507387960``` and password: ```password``` to enter the administrative panel
