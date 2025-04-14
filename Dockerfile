FROM openjdk:17-slim
 
# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip
 
# Install Azure Blob SDK for Python
RUN pip3 install azure-storage-blob
 
# Set working directory
WORKDIR /opt/synthea
 
# Copy all Synthea files
COPY . .
 
# Add upload script
COPY upload_to_blob.py /opt/upload_to_blob.py
 
# Run Synthea and then upload the data to Blob
CMD java -jar ./build/libs/synthea-with-dependencies.jar -p 5 && python3 /opt/upload_to_blob.py
