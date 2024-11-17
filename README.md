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

