AKS Deployment Guide
1. Setting Up the AKS Cluster

1.1 Install Required Tools
 1 - Azure CLI
 2 - Terraform
 3 - kubectl

1.2 Authenticate with Azure
Log in to Azure:
     az login


1.3 Deploy AKS with Terraform
Navigate to Terraform project directory:
     cd C:\Users\ASUS\Desktop\DevOps Assignment\terraform-aks

Initialize Terraform:
     terraform init

Plan the deployment:
     terraform plan

Apply the configuration to create the AKS cluster:
     terraform apply -auto-approve

If you see an error stating that the resource already exists, import it into Terraform:
     terraform import azurerm_kubernetes_cluster.aks /subscriptions/12f5b5f5-f7e8-4c0c-a65b-05187546f171/resourceGroups/my-aks-resource-group/providers/Microsoft.ContainerService/managedClusters/my-aks-cluster


2. Deploying the Application
We used a Deployment and Service to run a containerized app.

2.1 Create the Deployment YAML (deployment.yaml)
                apiVersion: apps/v1
                kind: Deployment
                metadata:
                name: nginx-deployment
                spec:
                replicas: 2
                selector:
                    matchLabels:
                    app: nginx
                template:
                    metadata:
                    labels:
                        app: nginx
                    spec:
                    containers:
                    - name: nginx
                        image: nginx:latest
                        ports:
                        - containerPort: 80

2.2 Create the Service YAML (service.yaml)
                apiVersion: v1
                kind: Service
                metadata:
                name: nginx-service
                spec:
                type: LoadBalancer
                selector:
                    app: nginx
                ports:
                    - protocol: TCP
                    port: 80
                    targetPort: 80

2.3 Deploy the App to AKS
        kubectl apply -f deployment.yaml
        kubectl apply -f service.yaml

Check if the pods are running:
        kubectl get pods


3. Checking If It Works
To verify that the app is running:

Check the External IP of the Service
        kubectl get svc
Look for the EXTERNAL-IP under nginx-service.

Test the Application
Open a browser and visit:
        http://74.178.198.218

use curl:
        curl http://74.178.198.218



4. Issue	Fix
Terraform error: "Resource already exists"	Use terraform import to import the existing resource into Terraform.
