# Web Application Helm Chart

A generic Helm chart for deploying web applications to Kubernetes.

## Features

- ✅ **Fully Generic**: No project-specific hardcoded values
- ✅ **ConfigMaps & Secrets**: Separate configuration from code
- ✅ **Volume Support**: Persistent storage, ConfigMap/Secret mounting, and more
- ✅ **Ingress Support**: Multiple ingress controllers supported
- ✅ **Health Checks**: Liveness and readiness probes
- ✅ **Flexibility**: External ConfigMaps/Secrets support

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

## Installing the Chart

```bash
# Basic installation
helm install my-app ./webapp

# With custom values
helm install my-app ./webapp -f my-values.yaml

# With inline values
helm install my-app ./webapp \
  --set image.repository=my-registry/my-app \
  --set image.tag=v1.0.0 \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=my-app.example.com
```

## Configuration

### Basic Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `app.name` | Application name | `my-webapp` |
| `app.namespace` | Kubernetes namespace | `default` |
| `image.repository` | Image repository | `my-registry/my-app` |
| `image.tag` | Image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |

### Deployment Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `deployment.replicas` | Number of replicas | `1` |
| `deployment.container.name` | Container name | `app` |
| `deployment.container.port` | Container port | `3000` |

### Resources

| Parameter | Description | Default |
|-----------|-------------|---------|
| `deployment.container.resources.requests.memory` | Memory request | `256Mi` |
| `deployment.container.resources.requests.cpu` | CPU request | `100m` |
| `deployment.container.resources.limits.memory` | Memory limit | `512Mi` |
| `deployment.container.resources.limits.cpu` | CPU limit | `500m` |

### ConfigMap & Secrets

| Parameter | Description | Default |
|-----------|-------------|---------|
| `configMap.enabled` | Enable ConfigMap creation | `true` |
| `configMap.data` | ConfigMap data | `{}` |
| `secret.enabled` | Enable Secret creation | `true` |
| `secret.data` | Secret data (base64 encoded) | `{}` |
| `externalConfigMap.enabled` | Use external ConfigMap | `false` |
| `externalConfigMap.name` | External ConfigMap name | `""` |
| `externalSecret.enabled` | Use external Secret | `false` |
| `externalSecret.name` | External Secret name | `""` |

### Service

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.enabled` | Enable service creation | `true` |
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `80` |
| `service.targetPort` | Target port | `3000` |

### Ingress

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.className` | Ingress class name | `""` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts configuration | `[]` |
| `ingress.tls` | Ingress TLS configuration | `[]` |

### Persistent Volume Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistentVolume.enabled` | Enable persistent storage | `false` |
| `persistentVolume.mountPath` | Mount path in container | `/data` |
| `persistentVolume.subPath` | Sub path within volume | `""` |
| `persistentVolume.size` | Storage size | `10Gi` |
| `persistentVolume.accessModes` | Access modes | `["ReadWriteOnce"]` |
| `persistentVolume.storageClass` | Storage class | `""` |

## Example Configurations

### Basic Web App

```yaml
# values.yaml
app:
  name: my-nextjs-app
  namespace: production

image:
  repository: my-registry/my-nextjs-app
  tag: "v1.2.3"

configMap:
  data:
    NODE_ENV: "production"
    API_URL: "https://api.example.com"

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: my-app.example.com
      paths:
        - path: /
          pathType: Prefix
```

### With External ConfigMap and Secrets

```yaml
# values.yaml
configMap:
  enabled: false

externalConfigMap:
  enabled: true
  name: my-existing-config

secret:
  enabled: false

externalSecret:
  enabled: true
  name: my-existing-secret
```

### With Persistent Storage

```yaml
# values.yaml
app:
  name: my-app
  namespace: production

image:
  repository: my-registry/my-app
  tag: "v1.0.0"

# Omogući trajno skladištenje
persistentVolume:
  enabled: true
  mountPath: /var/www/html/uploads
  size: 50Gi
  accessModes:
    - ReadWriteOnce
  storageClass: "fast-ssd"

deployment:
  replicas: 2
  container:
    resources:
      requests:
        memory: 512Mi
        cpu: 250m
      limits:
        memory: 1Gi
        cpu: 500m
```

### Simple Development Setup

```yaml
# values.yaml
persistentVolume:
  enabled: true
  mountPath: /app/data
  size: 5Gi
  # koristi default storage class
```

## Upgrade

```bash
helm upgrade my-app ./webapp -f my-values.yaml
```

## Rollback

```bash
helm rollback my-app 1
```