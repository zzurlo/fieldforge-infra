# Azure Infrastructure as Code

This repository contains Bicep templates for deploying Azure infrastructure.

## Repository Structure

```
├── main.bicep              # Main deployment template
├── modules/                # Reusable Bicep modules
├── environments/          
│   ├── dev/               # Development environment parameters
│   └── prod/              # Production environment parameters
```

## Deployment Instructions

To deploy the infrastructure, use the Azure CLI with the following commands:

### Development Environment

```bash
az deployment group create \
  --name dev-deployment \
  --resource-group your-resource-group \
  --template-file main.bicep \
  --parameters @environments/dev/parameters.json
```

### Production Environment

```bash
az deployment group create \
  --name prod-deployment \
  --resource-group your-resource-group \
  --template-file main.bicep \
  --parameters @environments/prod/parameters.json
```

## Prerequisites

- Azure CLI installed and configured
- Access to target Azure subscription
- Resource group created

## Parameters

The deployment accepts the following parameters:

- `environmentName`: The environment name (dev/prod)
- `location`: Azure region for resource deployment (defaults to resource group location)

## Adding New Modules

Place new Bicep modules in the `modules/` directory and reference them in `main.bicep` using the `module` keyword.