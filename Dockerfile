FROM openjdk:17
 
# Install Python & Azure SDK
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install azure-storage-blob
 
# Copy Synthea
WORKDIR /opt/synthea
COPY . .
 
# Add the upload script
COPY upload_to_blob.py /opt/upload_to_blob.py
 
# Run Synthea and then upload results to Blob
CMD java -jar ./build/libs/synthea-with-dependencies.jar -p 5 && python3 /opt/upload_to_blob.py
 
