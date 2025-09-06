for node in k8s-cp-2 k8s-cp-3; do
  gcloud compute scp /Users/sowmya/Documents/GitHub/Kubernetes/encryption-config.yaml $node:/etc/kubernetes/encryption-config.yaml --zone=us-east1-b
done



kubeadm join 10.0.0.100:6443 \
  --token ioaftf.t78bpln7iuncui3r \
  --discovery-token-ca-cert-hash sha256:63f0217d06fdf103bcd05f510d0c666629e084ddb7b75797d9dc7781e56ed2f1 \
  --control-plane \
  --certificate-key 9c42768a6beaae01754dd836b078135b980835844c926e6f800fc8903283702f



gcloud compute firewall-rules create allow-hc \
  --network=kubernetes-cluster \
  --action=ALLOW \
  --direction=INGRESS \
  --rules=tcp:6443 \
  --source-ranges=35.191.0.0/16,130.211.0.0/22


gcloud compute firewall-rules create allow-k8s-api \
  --network=kubernetes-cluster \
  --action=ALLOW \
  --direction=INGRESS \
  --rules=tcp:6443 \
  --source-ranges=10.0.0.0/24



# Allows Velero to manage objects in GCS
gcloud projects add-iam-policy-binding phrasal-method-470918-g9 \
  --member serviceAccount:velero-sa@phrasal-method-470918-g9.iam.gserviceaccount.com \
  --role roles/storage.admin

gcloud projects add-iam-policy-binding phrasal-method-470918-g9 \
  --member serviceAccount:velero-sa@phrasal-method-470918-g9.iam.gserviceaccount.com \
  --role roles/storage.objectAdmin

gcloud projects add-iam-policy-binding phrasal-method-470918-g9 \
  --member serviceAccount:velero-sa@phrasal-method-470918-g9.iam.gserviceaccount.com \
  --role roles/storage.objectCreator


gcloud iam service-accounts keys create ~/velero-sa-key.json \
  --iam-account velero-sa@phrasal-method-470918-g9.iam.gserviceaccount.com 



wget https://github.com/vmware-tanzu/velero/releases/latest/download/velero-v1.16.2-linux-amd64.tar.gz
tar -xvf velero-v1.16.2-linux-amd64.tar.gz
sudo mv velero-v1.16.2-linux-amd64/velero /usr/local/bin/
velero version
