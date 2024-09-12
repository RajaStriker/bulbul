#!/bin/bash

# deploy.sh
ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "No environment specified. Use 'dev' or 'prod'."
    exit 1
fi

echo "Starting deployment to $ENVIRONMENT environment..."

# Simulate deployment
if [ "$ENVIRONMENT" == "dev" ]; then
    echo "Deploying to development environment..."
    # Add your dev-specific deployment steps here
elif [ "$ENVIRONMENT" == "prod" ]; then
    echo "Deploying to production environment..."
    # Add your prod-specific deployment steps here
else
    echo "Unknown environment: $ENVIRONMENT"
    exit 1
fi

echo "Deployment to $ENVIRONMENT completed successfully!"

