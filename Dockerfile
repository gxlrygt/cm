FROM ruby:2.2.2
MAINTAINER Chris Volk cvolk@commercemtg.com

# Baked-in default env vars: Based on Dev settings.  
# Override on docker run command or docker compose file to set variables for other env's, including prod.
ENV PUMA_WORKERS=3 \
    PORT=5000 \
    RAILS_ENV="development" \
    RACK_ENV="development" \
    CRYPT_PASSWORD="KQWiA%eg9koxz@)85#F2IImPr7isxc71CkeUhk3LZuw_M6FztUp)Dn$lzKqg@2^7" \
    CRYPT_SALT="pg6il-zt&VMrw3#Q$4m-uK9gZb%zXXOcMHGuP1EL" \
    FREE_CONSULTATION_ENDPOINT="http://cmadmin.commercemtg.com/elliemae/api/FreeConsultation" \
    SECRET_KEY_BASE="046b3eac8fd2dbd62590c902efe89ad820d5132672350268d9994123d8f6dab52502e15145140ea184744093817d19fa774ff54af3cb56597a60574202f64ec3" \
    APPLICATION_BASE_DIR="/srv/www/htdocs" \
    APPLICATION_STATIC_CONTENT_REL_PATH="public" 

# Dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
	nginx 

# Setup nginx as the static content server, using $APPLICATION_BASE_DIR/public as it's content
COPY ./dockerfiles/default-site.conf /etc/nginx/sites-available/default

# Set services to start when image is run in container.
RUN update-rc.d nginx defaults

# Setup base application directory plus mount points for external image projects
# 
RUN mkdir -p $APPLICATION_BASE_DIR 

# Context for following commands
WORKDIR $APPLICATION_BASE_DIR

# Copy just the Gemfiles and run 'bundle install' separately to 
# allow for a layer that only changes if gems are added/modified/deleted,
# yielding smaller docker images and faster build times.  Do not change this.
COPY Gemfile Gemfile.lock ./
RUN  bundle install --jobs 20 --retry 5 \
  && bundle package --all

# Copy project files to runtime base dir (see WORKDIR, above).  Exceptions specified in ./.dockerignore.	
COPY . ./
RUN bundle exec rake assets:precompile assets:clean

# Ports accessible outside the container
EXPOSE 80 5000

# Configure an entry point, so we don't need to specify 
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# Default command if nothing supplied on command line:
# Run the application.
CMD ["puma -C /srv/www/htdocs/config/web_puma.rb 2>&1"]
