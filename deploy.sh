#!/bin/bash

# Set your desired branch name (replace with your actual branch)
BRANCH_NAME="main"

# Function to handle errors and print error messages
function handle_error() {
  echo "Error: $1" >&2  # >&2 redirects error message to stderr
  exit 1               # Exit the script with an error code
}

# 1. Stage, Commit, and Push to GitHub

# Check for unstaged changes
git diff --quiet --cached || handle_error "There are unstaged changes. Please stage them before running the script."

# Stage all changes
git add .

# Commit changes with a message
git commit -m "Change made: $(date)" || handle_error "Failed to commit changes."

# Push changes to GitHub
git push origin $BRANCH_NAME || handle_error "Failed to push changes to GitHub."

echo "Successfully pushed changes to GitHub branch: $BRANCH_NAME"

# 2. Install dependencies and build the app



npm install || handle_error "Failed to install dependencies."
npm run build || handle_error "Failed to build the application."

echo "Successfully built the application."

# 3. Upload the built files to the GCS bucket

# Set your GCS bucket name 
BUCKET_NAME="rachel-fried-bucket-2"

# Specify the build directory 
BUILD_DIR="build"

# Upload all files from the build directory to the GCS bucket
gsutil -m cp -r $BUILD_DIR/* gs://$BUCKET_NAME/ || handle_error "Failed to upload files to GCS bucket."

echo "Successfully uploaded files to GCS bucket: $BUCKET_NAME"

echo "Deployment completed!"