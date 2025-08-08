ConfigMaps: Ingesting Configuration Data
Goal: Provide configuration data to applications running in a pod.

Purpose: Decouple application configuration from the container image.

Method 1: As Environment Variables
When to use: For simple key-value pairs that your application reads at startup.

Two primary approaches:

Injecting all key-value pairs:

Pod YAML: Use the envFrom field inside the container spec.

Code Snippet:

YAML

envFrom:
  - configMapRef:
      name: app-config
Injecting specific key-value pairs:

Pod YAML: Use the env field as an array inside the container spec.

Code Snippet:

YAML

env:
  - name: APP_COLOR_OVERRIDE
    valueFrom:
      configMapKeyRef:
        name: app-config
        key: APP_COLOR
Method 2: As Mounted Files
When to use: For applications that expect their configuration in a file (e.g., application.properties).

YAML Structure:

Pod volumes: Define a volume that references the ConfigMap.

Code Snippet:

YAML

volumes:
  - name: config-volume
    configMap:
      name: app-config
Container volumeMounts: Mount the volume into the container's file system.

Code Snippet:

YAML

volumeMounts:
  - name: config-volume
    mountPath: /etc/config
Mounting a single file (Advanced):

Pod volumes: Use the items field inside the configMap section of the volumes definition.

Code Snippet:

YAML

volumes:
  - name: config-volume
    configMap:
      name: app-properties-config
      items:
        - key: application.properties
          path: app.properties