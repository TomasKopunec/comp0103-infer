# Use an official Maven image with Java 8
FROM gradle:7.6-jdk8

# Set working directory
WORKDIR /app

# Install necessary tools and libraries
RUN apt-get update && apt-get install -y curl unzip libsqlite3-0 openjdk-8-jdk maven xz-utils

# Install Meta Infer
RUN curl -L https://github.com/facebook/infer/releases/latest/download/infer-linux64-v1.1.0.tar.xz | tar -xJ && \
    mv infer-linux64-v1.1.0 /opt/infer && \
    ln -s /opt/infer/bin/infer /usr/local/bin/infer

# Download and setup SpotBugs
RUN curl -L https://github.com/spotbugs/spotbugs/releases/download/4.8.3/spotbugs-4.8.3.zip -o /opt/spotbugs.zip && \
    unzip /opt/spotbugs.zip -d /opt/ && \
    mv /opt/spotbugs-4.8.3 /opt/spotbugs && \
    ln -s /opt/spotbugs/bin/spotbugs /usr/local/bin/spotbugs

# Copy your verify.sh script into the container
COPY verify.sh /usr/local/bin/verify.sh
COPY add_spotbugs.sh /usr/local/bin/add_spotbugs.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/verify.sh
RUN chmod +x /usr/local/bin/add_spotbugs.sh

# Set the entrypoint to your script
ENTRYPOINT ["/usr/local/bin/verify.sh"]