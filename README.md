# Kubernetes
The repo Includes my learning modules for K8s
This repo is a learning journey for my  (K8s) certification. 
Install the minikube from the site:
 https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Farm64%2Fstable%2Fbinary+download

 ## What is minikube?
 It is a miniaturised version of K8s that can help in running pods in the local machine without a cluster creation.

 In every Documentation generally , the things start with Pods, Deployments, Services . But I feel like its better we start the journey with Namespaces.
 ## What is a Namepsace?
- Namespace is a logical way of grouping resources that gets deployed in K8s. 
- For an Example, there is an organization under which there are multiple projects. Each project has its own applications that needs to be deployed.
- For each project we create a namespace and divide them logically where access and resource restrictions can be placed.
``` sh
 kubectl get namespace
 kubectl get ns
 ```
 ns is the shot form for namespace
 The below are the namespaces created when cluster is initialized.
- Default: Created automatically when the cluster is set up 
- Kube-system: Reserved for the Kubernetes control plane components and other system-related pods 
- Kube-public: Automatically generated and accessible by all users, including those who are not authenticated
- kube-node-lease: This namespace holds Lease objects associated with each node. Node leases allow the kubelet to send heartbeats so that the control plane can detect node failure.


### Creating a Namespace

``` sh
kubectl create ns medical
```
The above command with create a namespace with the name medical. But I would advise to create resources in K8s using yaml files. This will help in setting up the Gitops. So, to create a sample yaml file without creating the resource, we can use the below command.
``` sh
kubectl create ns medical --dry-run=client -o yaml > medical/ns.yaml
```
Now to create the namespace from the yaml file run the below command,
``` sh
kubectl apply -f medical/ns.yaml
```
To check the resources that can be created under the namespace, we can use the following command.

``` sh 
kubectl api-resources namespaces=true
```

NAME                        SHORTNAMES   APIVERSION                     NAMESPACED   KIND
bindings                                 v1                             true         Binding
configmaps                  cm           v1                             true         ConfigMap
endpoints                   ep           v1                             true         Endpoints
events                      ev           v1                             true         Event
limitranges                 limits       v1                             true         LimitRange
persistentvolumeclaims      pvc          v1                             true         PersistentVolumeClaim
pods                        po           v1                             true         Pod
podtemplates                             v1                             true         PodTemplate
replicationcontrollers      rc           v1                             true         ReplicationController
resourcequotas              quota        v1                             true         ResourceQuota
secrets                                  v1                             true         Secret
serviceaccounts             sa           v1                             true         ServiceAccount
services                    svc          v1                             true         Service
controllerrevisions                      apps/v1                        true         ControllerRevision
daemonsets                  ds           apps/v1                        true         DaemonSet
deployments                 deploy       apps/v1                        true         Deployment
replicasets                 rs           apps/v1                        true         ReplicaSet
statefulsets                sts          apps/v1                        true         StatefulSet
localsubjectaccessreviews                authorization.k8s.io/v1        true         LocalSubjectAccessReview
horizontalpodautoscalers    hpa          autoscaling/v2                 true         HorizontalPodAutoscaler
cronjobs                    cj           batch/v1                       true         CronJob
jobs                                     batch/v1                       true         Job
leases                                   coordination.k8s.io/v1         true         Lease
endpointslices                           discovery.k8s.io/v1            true         EndpointSlice
events                      ev           events.k8s.io/v1               true         Event
ingresses                   ing          networking.k8s.io/v1           true         Ingress
networkpolicies             netpol       networking.k8s.io/v1           true         NetworkPolicy
poddisruptionbudgets        pdb          policy/v1                      true         PodDisruptionBudget
rolebindings                             rbac.authorization.k8s.io/v1   true         RoleBinding
roles                                    rbac.authorization.k8s.io/v1   true         Role
csistoragecapacities                     storage.k8s.io/v1              true         CSIStorageCapacity

Each of the resource will be learned/discussed individually.

To know the description of the namespace we can use the below command

``` sh
kubectl describe ns medical
```

As discussed early, namespaces are are logical grouping of resources. And we can put the limit on the resource utilization by creating resource quotes and limit ranges.


### Resource Quota

```sh
kubectl create resourcequota medical --dry-run=client -o yaml > medical/rq.yaml
```

As shown in medical/rq.yaml file, one can define the quota for multiple resources inside the namespace like pod,service,storage,configmap and secrets.

Lets create a Pod to test the same.

## What is a Pod?
Pod is the smallest deployable unit in the Kubernetes. It is equivalent to a VM. 
Then what is container ?
In simple terms, Kubernetes has created a wrapper class above the container and called it as a Pod. We can't deploy containers directly in Kubernetes. We can only deploy Pods which in turn run the containers inside it. 

```sh
kubectl run  pod nginx  --image=nginx --dry-run=client -o yaml > medical/pod.yaml
kubectl apply -f medical/pod.yaml
```
When we have tried to create the pod, it resulted in the below error.

`Error from server (Forbidden): error when creating "medical/pod.yaml": pods "pod" is forbidden: failed quota: full-quota: must specify limits.cpu for: pod; limits.memory for: pod; requests.cpu for: pod; requests.memory for: pod`

This is because, as we have applied the quota restrictions to the namespace, it is mandatory to add the same in Pod specification while deploying. Create the medical/pod2.yaml file and add the resource requests and limits. Or  Hint: Use the LimitRanger admission controller to force defaults for pods that make no compute resource requirements.

```sh
kubectl apply -f medical/pod2.yaml
```
- This will create the pod.
- Update the medical/rq.yaml file for pods value to 1 which means only one pod can be deployed under the namespace.
- Apply the changes.
- Create the new pod by changing the name in pod2.yaml. The following error will be thrown.
`Error from server (Forbidden): error when creating "medical/pod2.yaml": pods "pod2" is forbidden: exceeded quota: full-quota, requested: pods=1, used: pods=1, limited: pods=1`

Next topic ScopeSelector, LimitRanges
