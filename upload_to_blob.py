import os
from azure.storage.blob import BlobServiceClient
 
# ENV variables passed from container config
connect_str = os.environ['AZURE_STORAGE_CONNECTION_STRING']
container_name = os.environ['AZURE_BLOB_CONTAINER']
folder_path = '/opt/synthea/output/fhir'
 
blob_service_client = BlobServiceClient.from_connection_string(connect_str)
container_client = blob_service_client.get_container_client(container_name)
 
for filename in os.listdir(folder_path):
    file_path = os.path.join(folder_path, filename)
    if os.path.isfile(file_path):
        with open(file_path, "rb") as data:
            print(f"Uploading {filename}...")
            container_client.upload_blob(name=filename, data=data, overwrite=True)
