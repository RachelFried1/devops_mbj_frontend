#!/bin/bash



echo "Starting deployment process..."


git status


git add .


git commit -m "Changes made."


git push origin main



npm install



npm run build


# Upload built files to GCS bucket (replace with your credentials)
# Make sure you have authenticated gcloud and set the correct bucket name
gcloud auth activate-service-account --key-file /path/to/your/service_account_key.json


gcloud storage cp -r build/ gs://rachel-fried-bucket-2


echo "Deployment completed successfully."