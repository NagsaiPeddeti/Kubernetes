#!/bin/bash
# ===============================================================
# HA Kubernetes Cluster Backup Script
# Backs up: etcd snapshots + Velero cluster resources
# Retention: 7 days
# ===============================================================

# -------------------------
# GCP Service Account
# -------------------------
export GOOGLE_APPLICATION_CREDENTIALS="/etc/velero/credentials/velero-sa-key.json"

# -------------------------
# Config
# -------------------------
ETCDCTL_API=3
ETCD_ENDPOINTS="https://127.0.0.1:2379"
ETCD_CACERT="/etc/kubernetes/pki/etcd/ca.crt"
ETCD_CERT="/etc/kubernetes/pki/etcd/server.crt"
ETCD_KEY="/etc/kubernetes/pki/etcd/server.key"

GCS_BUCKET="k8s-etcd-backup"
ETCD_SNAPSHOT_DIR="/var/lib/etcd"
VELERO_NAMESPACES="kube-system,default"
RETENTION_DAYS=7

TIMESTAMP=$(date +%F)
ETCD_SNAPSHOT_FILE="${ETCD_SNAPSHOT_DIR}/snapshot-${TIMESTAMP}.db"

# -------------------------
# 1️⃣ Find ETCD Pod
# -------------------------
ETCD_POD=$(kubectl -n kube-system get pods -l component=etcd -o jsonpath='{.items[0].metadata.name}')
if [[ -z "$ETCD_POD" ]]; then
  echo "[$(date)] Error: No etcd pod found!"
  exit 1
fi

# -------------------------
# 2️⃣ Etcd Snapshot
# -------------------------
echo "[$(date)] Starting etcd snapshot..."
kubectl -n kube-system exec $ETCD_POD -- /usr/local/bin/etcdctl \
  --endpoints=$ETCD_ENDPOINTS \
  --cacert=$ETCD_CACERT \
  --cert=$ETCD_CERT \
  --key=$ETCD_KEY \
  snapshot save $ETCD_SNAPSHOT_FILE

if [[ $? -ne 0 ]]; then
  echo "[$(date)] Etcd snapshot failed!"
  exit 1
fi

# -------------------------
# 3️⃣ Upload etcd Snapshot to GCS
# -------------------------
echo "[$(date)] Uploading etcd snapshot to GCS..."
gsutil -o "Credentials:gs_service_key_file=$GOOGLE_APPLICATION_CREDENTIALS" \
  cp $ETCD_SNAPSHOT_FILE gs://${GCS_BUCKET}/etcd-snapshots/

if [[ $? -ne 0 ]]; then
  echo "[$(date)] Upload to GCS failed!"
  exit 1
fi

# -------------------------
# 4️⃣ Velero Backup of Cluster Resources
# -------------------------
TTL_HOURS=$((RETENTION_DAYS * 24))
echo "[$(date)] Starting Velero backup..."
velero backup create cluster-backup-${TIMESTAMP} \
  --include-namespaces $VELERO_NAMESPACES \
  --ttl ${TTL_HOURS}h

if [[ $? -ne 0 ]]; then
  echo "[$(date)] Velero backup failed!"
  exit 1
fi

# -------------------------
# 5️⃣ Cleanup Old Etcd Snapshots from GCS
# -------------------------
echo "[$(date)] Cleaning up old etcd snapshots..."
gsutil -o "Credentials:gs_service_key_file=$GOOGLE_APPLICATION_CREDENTIALS" ls gs://${GCS_BUCKET}/etcd-snapshots/ | \
  while read -r file; do
    # Extract date from filename: snapshot-YYYY-MM-DD.db
    file_date=$(basename $file | sed -E 's/snapshot-([0-9]{4}-[0-9]{2}-[0-9]{2})\.db/\1/')
    file_ts=$(date -d $file_date +%s)
    cutoff_ts=$(date -d "$RETENTION_DAYS days ago" +%s)
    if [[ $file_ts -lt $cutoff_ts ]]; then
      echo "Deleting old snapshot: $file"
      gsutil -o "Credentials:gs_service_key_file=$GOOGLE_APPLICATION_CREDENTIALS" rm $file
    fi
  done

echo "[$(date)] Backup completed successfully!"
