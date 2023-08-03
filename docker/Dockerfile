FROM perl:5.38.0
WORKDIR /app

# Core OS setup
RUN apt-get update
RUN apt-get install -y postgresql-client git vim

# Clean up
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Copy only the files needed for installing dependencies
COPY cpanfile* .
RUN cpanm --notest --installdeps .

# Copy the rest of the application source code
COPY . .

# Run the Catalyst application
CMD make server 