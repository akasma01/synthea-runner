FROM openjdk:17-jdk-slim
 
# Install dependencies
RUN apt-get update && apt-get install -y git maven unzip curl
 
# Clone Synthea
RUN git clone https://github.com/synthetichealth/synthea.git /opt/synthea
WORKDIR /opt/synthea
 
# Build Synthea
RUN ./gradlew build check test shadowJar
 
# Environment variable (default)
ENV PATIENT_COUNT=10
 
# Run Synthea
CMD java -jar ./build/libs/synthea-with-dependencies.jar -p $PATIENT_COUNT
