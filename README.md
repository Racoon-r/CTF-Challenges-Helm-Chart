# CTF-Challenges-Helm-Chart

Helm Chart to deploy challenges for CTF (cybersecurity competition). This will **not** create content, it will only deploy existing container image on a Kubernetes cluster. It comes with the ControlPlane project.

## Chart Details

This chart was created for the 404 CTF, therefore it does not cover every type of challenge.

- For basic TCP connection, it will drop all capabilities and run at user 1001, and for PWN with NSjailit will run in privilege access.

- For Web challenges, it will drop all capabilities and create an ingress. If it needs a database, another container will be deployed.

VM are not yet supported.

## Installing the Chart

To install the chart with the release name `challenge-1`:

```BASH
export HELM_EXPERIMENTAL_OCI=1
helm install challenge-1 -f values.yml oci://ghcr.io/racoon-r/controlplane-challenges/controlplane-challenges --namespace ctf-challs
```

## Uninstalling the Chart

To uninstall/delete the `challenge-1`:

```BASH
helm uninstall challenge-1 --namespace ctf-challs
```

## Configuration

Check the `values.yml` to change parameters.

## Parameters

### Challenge parameters

| Name                                           | Description                                                            | Value             |
| ---------------------------------------------- | ---------------------------------------------------------------------- | ----------------- |
| `challenge.name`                               | Challenge name                                                         | `challenge`       |
| `challenge.image.registry`                     | Challenge image registry                                               | `REGISTRY_NAME`   |
| `challenge.image.repository`                   | Challenge image repository                                             | `REPOSITORY_NAME` |
| `challenge.image.pullPolicy`                   | Challenge image pull policy                                            | `IfNotPresent`    |
| `challenge.image.pullSecrets`                  | Challenge image pull secrets                                           | `[]`              |
| `challenge.image.tag`                          | Challenge image tag                                                    | `latest`          |
| `challenge.image.digest`                       | Challenge image digest in the way sha256:aaa. It will override the tag | `""`              |
| `challenge.containerPorts`                     | Challenge image listenning port(s)                                     | `[]`              |
| `challenge.livenessProbe.enabled`              | Enable liveness probe                                                  | `true`            |
| `challenge.livenessProbe.httpGetPath`          | Path to access on the HTTP server                                      | `nil`             |
| `challenge.livenessProbe.port`                 | Port for livenessProbe                                                 | `4000`            |
| `challenge.livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe                                | `1`               |
| `challenge.livenessProbe.periodSeconds`        | Period seconds for livenessProbe                                       | `5`               |
| `challenge.livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe                                      | `10`              |
| `challenge.livenessProbe.failureThreshold`     | Failure threshold for livenessProbe                                    | `5`               |
| `challenge.livenessProbe.successThreshold`     | Success threshold for livenessProbe                                    | `1`               |
| `challenge.readinessProbe.enabled`             | Enable readiness probe                                                 | `true`            |
| `challenge.readinessProbe.httpGetPath`         | Path to access on the HTTP server                                      | `nil`             |
| `challenge.readinessProbe.port`                | Port for readinessProbe                                                | `4000`            |
| `challenge.readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe                               | `1`               |
| `challenge.readinessProbe.periodSeconds`       | Period seconds for readinessProbe                                      | `5`               |
| `challenge.readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe                                     | `10`              |
| `challenge.readinessProbe.failureThreshold`    | Failure threshold for readinessProbe                                   | `5`               |
| `challenge.readinessProbe.successThreshold`    | Success threshold for readinessProbe                                   | `1`               |
| `challenge.replicaCount`                       | Set number of replicas. Override by autoscaling                        | `1`               |

### Autoscaling parameters

| Name                                                      | Description                    | Value   |
| --------------------------------------------------------- | ------------------------------ | ------- |
| `challenge.autoscaling.enabled`                           | Enable autoscaling with HPA    | `false` |
| `challenge.autoscaling.minReplicas`                       | Set minimum number of replicas | `1`     |
| `challenge.autoscaling.maxReplicas`                       | Set maximum numer of replicas  | `3`     |
| `challenge.autoscaling.targetCPUUtilizationPercentage`    | Percentage of CPU to reach     | `80`    |
| `challenge.autoscaling.targetMemoryUtilizationPercentage` | Percentage of memory to reach  | `80`    |

### Database parameters (optional)

| Name                                          | Description                                                      | Value             |
| --------------------------------------------- | ---------------------------------------------------------------- | ----------------- |
| `database.enabled`                            | Enable database deployment                                       | `false`           |
| `database.name`                               | Database name                                                    | `db`              |
| `database.image.registry`                     | Database image registry                                          | `REGISTRY_NAME`   |
| `database.image.repository`                   | Database image repository                                        | `REPOSITORY_NAME` |
| `database.image.tag`                          | Database image tag                                               | `""`              |
| `database.image.pullPolicy`                   | Database image pull policy                                       | `IfNotPresent`    |
| `database.image.pullSecrets`                  | Database image pull secrets                                      | `[]`              |
| `database.image.digest`                       | Database image digest in the way sha256:aa. It will override tag | `nil`             |
| `database.containerPorts[0].name`             | Container port name                                              | `db`              |
| `database.containerPorts[0].port`             | Container port number                                            | `3306`            |
| `database.livenessProbe.enabled`              | Enable liveness probe                                            | `nil`             |
| `database.livenessProbe.httpGetPath`          | Path to access on the HTTP server                                | `nil`             |
| `database.livenessProbe.port`                 | Port for livenessProbe                                           | `3306`            |
| `database.livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe                          | `1`               |
| `database.livenessProbe.periodSeconds`        | Period seconds for livenessProbe                                 | `5`               |
| `database.livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe                                | `10`              |
| `database.livenessProbe.failureThreshold`     | Failure threshold for livenessProbe                              | `5`               |
| `database.livenessProbe.successThreshold`     | Success threshold for livenessProbe                              | `5`               |
| `database.readinessProbe.enabled`             | Enable readiness probe                                           | `nil`             |
| `database.readinessProbe.httpGetPath`         | Path to access on the HTTP server                                | `nil`             |
| `database.readinessProbe.port`                | Port for readinessProbe                                          | `3306`            |
| `database.readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe                         | `1`               |
| `database.readinessProbe.periodSeconds`       | Period seconds for readinessProbe                                | `5`               |
| `database.readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe                               | `10`              |
| `database.readinessProbe.failureThreshold`    | Failure threshold for readinessProbe                             | `5`               |
| `database.readinessProbe.successThreshold`    | Success threshold for readinessProbe                             | `5`               |
| `database.ingress.enabled`                    | Enable ingress for database                                      | `true`            |
| `database.ingress.className`                  | Ingress class for database                                       | `""`              |
| `database.ingress.annotations`                | Annotations for database                                         | `{}`              |
| `database.ingress.hosts`                      | Host to access database                                          | `nil`             |
| `database.ingress.tls`                        | Enable TLS configuration                                         | `[]`              |
| `database.volumeMounts`                       | Volume to mount for database                                     | `[]`              |
| `database.resources`                          | Custom ressources for database                                   | `{}`              |

### Service account parameters

| Name                         | Description                                                     | Value          |
| ---------------------------- | --------------------------------------------------------------- | -------------- |
| `serviceAccount.create`      | Create SA for the challenge                                     | `true`         |
| `serviceAccount.automount`   | Mount SA API credentials                                        | `true`         |
| `serviceAccount.annotations` | Annotations for SA                                              | `{}`           |
| `serviceAccount.name`        | Name for SA. `default` is SA by default in Kubernetes namespace | `controlplane` |

### Security Context parameters

| Name                                     | Description                                    | Value     |
| ---------------------------------------- | ---------------------------------------------- | --------- |
| `podSecurityContext`                     | Enabled pod security context                   | `{}`      |
| `securityContext.capabilities.drop`      | Drop all or specific capabilities              | `["ALL"]` |
| `securityContext.readOnlyRootFilesystem` | Set root filesystem in read only - RO          | `true`    |
| `securityContext.runAsNonRoot`           | Run challenge container as non root            | `true`    |
| `securityContext.runAsUser`              | Set UUID of user                               | `1000`    |
| `securityContext.privileged`             | Set to true for privileged challenge container | `false`   |

### Service parameters

| Name                          | Description                                                   | Value      |
| ----------------------------- | ------------------------------------------------------------- | ---------- |
| `service.type`                | Service type. `NodePort` for classic TCP, `ClusterIP` for Web | `NodePort` |
| `service.ports[0].port`       | Port number                                                   | `4000`     |
| `service.ports[0].name`       | Service name                                                  | `tcp`      |
| `service.ports[0].targetPort` | Target port                                                   | `tcp`      |
| `service.ports[0].nodePort`   | specific NodePort                                             | `30005`    |

### Ingress parameters

| Name                                    | Description                          | Value         |
| --------------------------------------- | ------------------------------------ | ------------- |
| `ingress.enabled`                       | Enable ingress for Web challenges    | `false`       |
| `ingress.className`                     | Class name                           | `""`          |
| `ingress.annotations`                   | Custom annotations for ingress       | `{}`          |
| `ingress.hosts[0].host`                 | Hostname of Web challenge            | `web.host.fr` |
| `ingress.hosts[0].paths[0].path`        | Path of Web challenge                | `/`           |
| `ingress.hosts[0].paths[0].pathType`    | Path type                            | `Prefix`      |
| `ingress.hosts[0].paths[0].serviceName` | Name of service linked to deployment | `nil`         |
| `ingress.hosts[0].paths[0].servicePort` | Service port                         | `8000`        |
| `ingress.tls`                           | Enable TLS configuration             | `[]`          |

### Other parameters

| Name           | Description                    | Value |
| -------------- | ------------------------------ | ----- |
| `resources`    | Custom ressources              | `{}`  |
| `volumes`      | Add volume to challenge        | `[]`  |
| `volumeMounts` | How to mount the volume        | `[]`  |
| `nodeSelector` | Node to select                 | `{}`  |
| `tolerations`  | Tolerations for pod assignment | `[]`  |
| `affinity`     | Affinity for pod assignment    | `{}`  |
