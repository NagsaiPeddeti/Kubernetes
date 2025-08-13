Task 1: Pods and ReplicaSets
Your first task is to work with a basic Pod and a ReplicaSet.

Create a Pod named my-pod that uses the nginx:1.20 image.

Once the Pod is running, manually delete it using the kubectl delete pod command.

$ alias k=kubectl
$ k run pod my-pod --image=nginx --dry-run=client -o yaml > pod1.yaml
$ k delete pod my-pod

Kubernetes Workload and Controller Summary
This document provides a summary of the Kubernetes workload types and controllers we've discussed today, from stateful applications to one-off and scheduled tasks.

StatefulSets and Persistent Storage
A StatefulSet is a workload API object used to manage stateful applications. It manages Pods with stable, persistent storage and network identifiers.

volumeClaimTemplates: This field is the key to automatic storage management. It acts as a blueprint for creating a unique PersistentVolumeClaim (PVC) for each Pod in the StatefulSet. When a new Pod is created, the StatefulSet controller automatically creates a corresponding PVC.

Automatic Provisioning: The Kubernetes PersistentVolume controller then sees the new PVC and dynamically provisions a new PersistentVolume (PV) that meets the specified storage requirements (e.g., 1Gi of storage). The PV is then bound to the PVC, and the storage becomes available to the Pod.

serviceName and Headless Service: The serviceName field is used to link the StatefulSet to a Headless Service (a service with clusterIP: None). This service is crucial because it provides a predictable and stable DNS name for each individual Pod, like mystatefulset-0.database.default.svc.cluster.local, which is essential for stateful applications like databases to find and communicate with each other.

Jobs and CronJobs
These controllers are designed for tasks that run to completion, as opposed to workloads that run continuously.

Job: A Job is designed for one-off tasks. It creates one or more Pods and ensures that they run until a specified number successfully terminate. A key setting is restartPolicy: Never, which ensures the Pod doesn't restart once its task is finished.

CronJob: A CronJob automates the creation of Jobs on a recurring, time-based schedule, just like a Unix crontab. The primary difference in the manifest is that a CronJob contains a jobTemplate, which is a full Job specification that the CronJob controller uses to create a new Job at each scheduled interval.

Other Workload Controllers
We've also covered other important workload types and controllers:

Deployments vs. ReplicaSets: A Deployment is the most common controller for stateless applications. It manages the lifecycle of your Pods, handling rolling updates, rollbacks, and self-healing. A ReplicaSet is a lower-level controller that is managed by a Deployment. Its sole purpose is to ensure that a specified number of Pod replicas are running at all times. A Deployment uses ReplicaSets to achieve its goals, but you should always interact with the Deployment and not the ReplicaSet directly.

DaemonSets: This controller ensures that a Pod runs on every node in the cluster (or a selected subset). It's typically used for system-level background tasks, such as log collectors or monitoring agents.