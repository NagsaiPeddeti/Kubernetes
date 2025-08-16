 2  kubectl get pods
    3  minikube start
    4  alias k-kubectl
    5  alias k=kubectl
    6  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.0/deploy/static/provider/cloud/deploy.yaml
    7  k get pods
    8  k config --help
    9  k get deploy -n kube-system
   10  k get daemonset -n kube-system
   11  k get ns
   12  k get deploy -n ingress-nginx
   13  k get svc -n ingress-nginx
   14  minikube ip
   15  curl http://192.168.48.2
   16  curl http://192.168.49.2
   17  curl https://192.168.49.2
   18  k get svc -n ingress-nginx
   19  curl http://localhost
   20  curl http://10.96.202.137/
   21  k get deploy
   22  k get svc
   23  k get svc -n ingress-nginx
   24  k delete svc nginx-service
   25  cd medical/networking/
   26  k apply -f svc1.yaml 
   27  k get svc
   28  k create ingress --dry-run=client -o yaml > ingress1.yaml
   29  k create ingress web-server-ingress --dry-run=client -o yaml > ingress1.yaml
   30  k create ingress --help
   31  k create ingress web-server-ingress --rule=sample.example.com=nginx-service:80 --dry-run=client -o yaml > ingress1.yaml
   32  k create ingress web-server-ingress --rule=sample.example.com/=nginx-service:80 --dry-run=client -o yaml > ingress1.yaml
   33  k apply -f ingress1.yaml 
   34  k get ingress
   35  vi /etc/hosts
   36  sudo vi /etc/hosts
   37  curl http://sample.example.com
   38  curl http://sample.example.com/
   39  k get pods
   40  k exec -it nginx-deployment-664fcb7fb8-72qm8 -- /bin/curl http://localhost/ 
   41  k get ingress
   42  k get svc
   43  k apply -f ingress1.yaml 
   44  curl http://sample.example.com/
   45  k apply -f ingress1.yaml 
   46  k get ing
   47  k delete ing web-server-ingress
   48  k apply -f ingress1.yaml 
   49  k get ing
   50  curl http://sample.example.com/
   51  k apply -f ingress1.yaml 
   52  k get ing
   53  k delete ing web-server-ingress
   54  k apply -f ingress1.yaml 
   55  k get ing
   56  curl http://sample.example.com/
   57  k delete ing web-server-ingress
   58  k apply -f ingress1.yaml 
   59  curl http://sample.example.com/
   60  k get ing
   61  k describe ing/web-server-ingress
   62  history