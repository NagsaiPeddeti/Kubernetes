    1  ls
    2  k get pods
    3  kubectl get pods
    4  minikube start
    5  alias k=kubectl
    6  k get pods
    7  ls
    8  cd medical/
    9  ls
   10  cd workloads/
   11  ls
   12  k run pod my-pod --image=nginx:latest 
   13  k get pods
   14  watch k get pods
   15  k get pods
   16  k describe pod pod
   17  k get pod
   18  k get pod/pod -o yaml
   19  k run pod my-pod --image=nginx:latest --dry-run=client -o yaml > pod1.yaml
   20  ls
   21  vi pod1.yaml 
   22  k apply -f pod1.yaml 
   23  k get pods
   24  k delete my-pod
   25  k delete pod my-pod
   26  k delete pod pod
   27  touch replicaset1.yaml
   28  k apply -f replicaset1.yaml 
   29  k get pods
   30  k delete pod/nginx-rs-bb5r5
   31  k get pods
   32  k get rs
   33  k apply -f replicaset1.yaml 
   34  k get pods
   35  k apply -f replicaset1.yaml 
   36  k get pods
   37  k describe pod/nginx-rs-bhv99
   38  k get rs
   39  k describe rs/nginx-rs
   40  k create deploy --image=httpd
   41  k create deploy web-app --image=httpd:2.4 --dry-run=client -o yaml > deploy1.yaml
   42  ld
   43  ls
   44  k get rs
   45  k delete rs --all
   46  k get rs
   47  k apply -f deploy1.yaml
   48  k get rs
   49  k get pods
   50  k set image deploy/web-app httpd=httpd:2.5
   51  k get pods
   52  k apply -f deploy1.yaml 
   53  k get pods
   54  k get rs
   55  k rollback deploy/web-app
   56  k --help
   57  k explain rollout
   58  k rollout --help
   59  k rollout undo deploy/web-app
   60  k get rs
   61  k get pods
   62  k get deployment/web-app -o yaml
   63  k create daemonset node-monitor --image=busybox --dry-run=client -o yaml > daemonset1.yaml
   64  k create daemonset node-monitor --dry-run=client -o yaml > daemonset1.yaml
   65  k run daemonset node-monitor --image=busybox --dry-run=client -o yaml > daemonset1.yaml
   66  ls
   67  k apply -f daemonset1.yaml 
   68  k get ds
   69  k get pods
   70  k logs pod/node-monitor-ks8cs
   71  k create statefulset database --image=mongo:4.4 --dry-run=client -o yaml > stateful1.yaml
   72  k create statefulset database  --dry-run=client -o yaml > stateful1.yaml
   73  k create statefulset database --replicas=2  --dry-run=client -o yaml > stateful1.yaml
   74  k apply -f stateful1.yaml 
   75  k get pods
   76  k get pv
   77  k get pvs
   78  k get pvc
   79  k create job pi-calculator --image=perl --dry-run=client -o yaml > job1.yaml
   80  k apply -f job1.yaml 
   81  k get pods
   82  k get deploy
   83  k delete delete deploy/ web-app
   84  k delete delete deploy/web-app
   85  k delete deploy/web-app
   86  k get rs
   87  k get ds
   88  k delete ds/node-monitor
   89  k get ss
   90  k get statefulset
   91  k delete statefulset/mystatefulset
   92  k get jobs
   93  k get pods
   94  k logs pi-calculator-rn9r7
   95  k create cronjob hello-cronjob --image=busybox --dry-run=client -o yaml > cronjob1.yaml
   96  k create cronjob hello-cronjob --image=busybox --schedule="* * * * *"  --dry-run=client -o yaml > cronjob1.yaml
   97  hisotry
   98  history
   99  history > history.md
