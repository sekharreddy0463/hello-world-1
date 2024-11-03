# Use a base image with both JDK and Tomcat
FROM tomcat:9.0-jdk11

# Install git to clone the repository
RUN apt-get update && apt-get install -y git && apt-get clean

# Set the working directory
WORKDIR /usr/src/app

# Clone the Java project repository (replace with your repository URL)
RUN git clone  https://github.com/sekharreddy0463/hello-world-1.git
# Move to the project directory
WORKDIR /usr/src/app/hello-world-1/webapp

# Install Maven to build the project
RUN apt-get update && apt-get install -y maven

# Build the project and generate the WAR file
RUN mvn clean package

# Copy the WAR file to Tomcat's webapps directory
#RUN cp usr/src/app/hello-world-1/webapp/target/* /usr/local/tomcat/webapps/
#RUN # Replace with the actual path where the WAR file is generated
#RUN cp -r /usr/src/app/hello-world-1/webapp/target/* /usr/local/tomcat/webapps/
RUN cp -r target/* /usr/local/tomcat/webapps/
# Expose Tomcat port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
