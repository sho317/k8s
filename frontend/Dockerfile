# Use the standard Tomcat base image
FROM tomcat

# Set the working directory
WORKDIR /usr/local/tomcat

# Remove default web applications
USER root
RUN rm -rf webapps/*

# Copy your application into the container
COPY ./app webapps/ROOT

# Expose port 8080
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]

