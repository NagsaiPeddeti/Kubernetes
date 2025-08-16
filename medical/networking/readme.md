Automated TLS Certificates
While you know how to configure spec.tls with a Secret, manually creating and renewing those certificates is a hassle. A very common and recommended practice is to use a tool called cert-manager.

How it works: cert-manager is a Kubernetes add-on that watches for specific resources (like Certificate or Ingress with a special annotation). It can then automatically request, provision, and renew TLS certificates from providers like Let's Encrypt. It stores the resulting certificates in a Kubernetes Secret, which your Ingress can then reference. This completely automates the secure traffic flow and eliminates manual certificate management.

Advanced Routing & Traffic Management
Ingress can be used for more than just simple routing. With the right annotations, you can perform advanced traffic management.


Weighted Load Balancing: You can split traffic between different versions of your application. This is a common strategy for Canary Deployments, where you route a small percentage of traffic (e.g., 10%) to a new version to test it in production before sending all traffic.

A/B Testing: You can route users to different versions of your application based on criteria like HTTP headers or cookies. This is useful for testing new features or UI changes.

These advanced features are highly dependent on the Ingress Controller you're using and are configured via specific annotations.


Kubernetes Gateway API Mind Map 🗺️
Core Concepts
Standardization: A new, official Kubernetes API for networking.

Role-Oriented: Separates responsibilities for different personas.

Expressive: Supports advanced routing rules beyond Ingress.

Extensible: Can be extended with custom policies and CRDs.

Key Resources
GatewayClass
Role: Infrastructure Provider / Cluster Operator.

What it is: Defines a "type" of gateway.

Purpose: Links a Gateway to a specific controller (e.g., NGINX, Cilium, Istio).

Example: gatewayClassName: my-nginx-class.

Gateway
Role: Cluster Operator.

What it is: The actual load balancer or entry point.

Purpose: Exposes a set of listeners (ports, hostnames).

Example: A Gateway listening on port 80 for www.example.com.

HTTPRoute
Role: Application Developer.

What it is: Defines the routing rules for an application.

Purpose: Attaches to a Gateway and directs traffic to a service based on path, headers, etc.

Example: An HTTPRoute for /blog that sends traffic to the blog-service.

Other Route Resources
TLSRoute

TCPRoute

UDPRoute

GRPCRoute

Benefits
Clear Roles
Infrastructure Provider: Manages the GatewayClass definition.

Cluster Operator: Deploys and manages the Gateway.

Application Developer: Creates and manages their HTTPRoute in their own namespace.

Portability
Since the API objects are standardized, you can switch from one controller to another without changing your YAML manifests.

Advanced Functionality
Native support for traffic splitting (canary deployments).

Header and query parameter matching.

Cross-namespace routing.

Controller Independence
Allows multiple, different controllers to run in the same cluster.

Examples: NGINX for ingress, Cilium for CNI and service mesh, etc.


