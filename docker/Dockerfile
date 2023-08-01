FROM perl:5.34
WORKDIR /app

# Core OS setup
RUN apt-get update && apt-get install -y postgresql-client git vim
RUN cpan App::cpanminus

# Copy only the files needed for installing dependencies
COPY cpanfile .
RUN cpanm --notest --installdeps .

# Copy the rest of the application source code
COPY . .

# Run the Catalyst application
CMD make server 