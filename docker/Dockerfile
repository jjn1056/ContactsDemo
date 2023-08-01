FROM perl:5.34
WORKDIR /app
COPY . .

# Need this to run migrations
RUN apt-get update && apt-get install -y postgresql-client

# Install cpanm (CPAN Minus) to manage Perl module dependencies
RUN cpan App::cpanminus
RUN cpanm --notest --installdeps .

# Run the Catalyst application
CMD make server 