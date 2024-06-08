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

### Challenge parameters

| Name | Default value | Description |
| -------- | -------- | ------- |
| name | `""` | Challenge name |
| image.registry | `""` | Challenge image registry |
| image.repository | `""` | Challenge image repository |
| image.pullSecrets | `[]` | Challenge image pull secrets |
| image.pullPolicy | `IfNotPresent` | Challenge image pull policy |
| image.tag | `""` | Challenge image tag |
| image.digest | `[]` | Challenge image digest in the way `sha256:aaa`. It will override the tag |
| containerPorts | `[]` | Challenge image listenning port(s) |
| livenessProbe.enabled | `true` | Enable liveness probe |
| livenessProbe.httpGetPath | `` | HTTP path to check for liveness probe (only for challenges with ingress) |
| livenessProbe.port | `4000` | Port to check for liveness probe |
| livenessProbe.initialDelaySeconds | `1` | Initial delay in seconds for liveness probe |
| livenessProbe.periodSeconds | `10` | Frequency of check for
liveness probe |
| livenessProbe.timeoutSeconds | `10` | Time to wait before failure for liveness probe |
| livenessProbe.failureThreshold | `5` | Number of failure allowed for liveness probe |
| livenessProbe.successThreshold | `1` | Must be set to 1 |
| readinessProbe.enabled | `true` | Enable readiness probe |
| readinessProbe.httpGetPath | `` | HTTP path to check for readiness probe (only for challenges with ingress) |
| readinessProbe.port | `4000` | Port to check for readiness probe |
| readinessProbe.initialDelaySeconds | `1` | Initial delay in seconds for readiness probe |
| readinessProbe.periodSeconds | `10` | Frequency of check for
readiness probe |
| readinessProbe.timeoutSeconds | `10` | Time to wait before failure for readiness probe |
| readinessProbe.failureThreshold | `5` | Number of failure allowed for readiness probe |
| readinessProbe.successThreshold | `1` | Must be set to 1 |
| replicaCount | `1` | Set number of replicas. Override by autoscaling |

### Autoscaling parameters

| Name | Default value | Description |
| ----- | ---- | ---- |
| autoscaling.enabled | `false` | Enable autoscaling with HPA |
| autoscaling.minReplicas | `1` | Set minimum number of replicas |
| autoscaling.maxReplicas | `3` | Set maximum numer of replicas |
| autoscaling.targetCPUUtilizationPercentage | `80` | Percentage of CPU to reach |
| autoscaling.targetMemoryUtilizationPercentage | `80` | Percentage of memory to reach |

### Database parameters

| Name | Default value | Description |
| ----- | ------ | ------ |
| database.enabled | `false` | Enable database deployment |
| <span>database.name</span> | `db` | Database name |
| image.registry | `""` | Database image registry |
| image.repository | `""` | Database image repository |
| image.tag | `""` | Database image tag |
| image.digest | `""` | Database image digest in the way `sha256:aa`. It will override tag |
| image.pullPolicy | `IfNotPresent` | Database image pull policy |
| image.pullSecrets | `[]` | Database image pull secrets |
| image.containerPorts | `[name: db, port: 3306]` | Database container port |
| livenessProbe.enabled | `true` | Enable liveness probe |
| livenessProbe.httpGetPath | `` | HTTP path to check for liveness probe (only for database with ingress) |
| livenessProbe.port | `3306` | Port to check for liveness probe |
| livenessProbe.initialDelaySeconds | `1` | Initial delay in seconds for liveness probe |
| livenessProbe.periodSeconds | `10` | Frequency of check for
liveness probe |
| livenessProbe.timeoutSeconds | `10` | Time to wait before failure for liveness probe |
| livenessProbe.failureThreshold | `5` | Number of failure allowed for liveness probe |
| livenessProbe.successThreshold | `1` | Must be set to 1 |
| readinessProbe.enabled | `true` | Enable readiness probe |
| readinessProbe.httpGetPath | `` | HTTP path to check for readiness probe (only for database with ingress) |
| readinessProbe.port | `3306` | Port to check for readiness probe |
| readinessProbe.initialDelaySeconds | `1` | Initial delay in seconds for readiness probe |
| readinessProbe.periodSeconds | `10` | Frequency of check for
readiness probe |
| readinessProbe.timeoutSeconds | `10` | Time to wait before failure for readiness probe |
| readinessProbe.failureThreshold | `5` | Number of failure allowed for readiness probe |
| readinessProbe.successThreshold | `1` | Must be set to 1 |
| ingress.enabled | `true` | Enable ingress for database |
| ingress.className  `""` | Ingress class for database |
| ingress.annotations | `{}` | Annotations for database |
| ingress.hosts | `` | Host to access database |
| ingress.tls | `[]` | Enable TLS configuration |
| volumeMounts | `[]` | Volume to mount for database |
| ressources | `{}` | Custom ressources for database |

### Service account parameters

| Name | Default value | Description |
| ----- | ----- | ----- |
| create | `true` | Create SA for the challenge |
| automount | `true` | Mount SA API credentials |
| annotations | `{}` | Annotations for SA |
| name | `controlplane` | Name for SA. `default` is SA by default in Kubernetes namespace |

### Security context parameters

| Name | Default value | Description |
| ---- | ---- | ---- |
| podSecurityContext | `` | Enabled pod security context |
| securityContext.capabilities.drop | `[ALL]` | Drop all or specific capabilities |
| securityContext.readOnlyRootFilesystem | `true` | Set root filesystem in read only - RO |
| securityContext.runAsNonRoot | `true` | Run challenge container as non root |
| securityContext.runAsUser | `1000` | Set UUID of user |
| securityContext.privileged | `false` | Set to true for privileged challenge container |

### Service parameters

| Name | Default value | Description |
| ----- | ----- | ----- |
| type | `NodePort` | Service type. `NodePort` for classic TCP, `ClusterIP` for Web |
| ports | `[port: 4000, name: tcp, targetPort: 4000, nodePort: 30005]` | Set port number, name and target port. A NodePort can be specified |

### Ingress parameters

| Name | Default value | Description |
| ---- | ---- | ---- |
| enabled | `false` | Enable ingress for Web challenges |
| className | `""` | Class name |
| annotations | `{}` | Custom annotations for ingress |
| hosts[].host | `web.host.fr` | Hostname of Web challenge |
| hosts[].paths[].path | `/` | Path of Web challenge |
| hosts[].paths[].pathType | `Prefix` | Path type |
| hosts[].paths[].serviceName | `""` | Name of service linked to deployment |
| hosts[].paths[].servicePort | `8000` | Service port |
| tls | `[]` | Enable TLS configuration |

### Other parameters

| Name | Default value | Description |
| ---- | ---- | ---- |
| ressources | `{}` | Custom ressources |
| volumes | `[]` | Add volume to challenge |
| volumeMounts | `[]` | How to mount the volume |
| nodeSelector | `{}` | Node to select |
| tolerations | `[]` | Tolerations for pod assignment |
| affinity | `{}` | Affinity for pod assignment |

---

@Racoon-r
