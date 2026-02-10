# from https://github.com/a2labsllc/DEPOT-final/blob/main/deployment/v2/kubernetes.md
echo "Creating Kubernetes namespace..."
kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: oai-tutorial
  labels:
    pod-security.kubernetes.io/warn: "privileged"
    pod-security.kubernetes.io/audit: "privileged"
    pod-security.kubernetes.io/enforce: "privileged"
EOF

echo "Configuring docker registry secret..."
DOCKER_USERNAME=dstrube
DOCKER_PASSWORD=[redacted]
DOCKER_EMAIL=dstrube3@gatech.edu

kubectl create secret docker-registry regcred \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=${DOCKER_USERNAME} \
  --docker-password=${DOCKER_PASSWORD} \
  --docker-email=${DOCKER_EMAIL} \
  -n oai-tutorial

# from https://github.com/a2labsllc/DEPOT-final/blob/main/deployment/v2/5gcore.md
echo "Setting OAI 5G core network git download..."
TARGET=5324eeaccd8bfefc726df54f587236df30332e25

cd ~/oai-cn5g-fed
git checkout $TARGET

echo "Updating the subscriber information..."
SUB_SQL_FILE=charts/oai-5g-core/mysql/initialization/oai_db-basic.sql

MARKER="DEPOT: Updated"

if ! grep -q "$MARKER" $SUB_SQL_FILE; then
    echo "-- $MARKER" >> $SUB_SQL_FILE &&
    echo $'INSERT INTO `AuthenticationSubscription` (`ueid`, `authenticationMethod`, `encPermanentKey`, `protectionParameterId`, `sequenceNumber`, `authenticationManagementField`, `algorithmId`, `encOpcKey`, `encTopcKey`, `vectorGenerationInHss`, `n5gcAuthMethod`, `rgAuthenticationInd`, `supi`) VALUES
(\'208990100001124\', \'5G_AKA\', \'fec86ba6eb707ed08905757b1bb44b8f\', \'fec86ba6eb707ed08905757b1bb44b8f\', \'{"sqn": "000000000020", "sqnScheme": "NON_TIME_BASED", "lastIndexes": {"ausf": 0}}\', \'8000\', \'milenage\', \'c42449363bbad02b66d16bc975d77cc1\', NULL, NULL, NULL, NULL, \'208990100001124\');' | tee -a $SUB_SQL_FILE &&
    echo $'INSERT INTO `SessionManagementSubscriptionData` (`ueid`, `servingPlmnid`, `singleNssai`, `dnnConfigurations`) VALUES
(\'208990100001124\', \'20899\', \'{"sst": 1, "sd": "10203"}\',\'{"oai":{"pduSessionTypes":{ "defaultSessionType": "IPV4"},"sscModes": {"defaultSscMode": "SSC_MODE_1"},"5gQosProfile": {"5qi": 6,"arp":{"priorityLevel": 1,"preemptCap": "NOT_PREEMPT","preemptVuln":"NOT_PREEMPTABLE"},"priorityLevel":1},"sessionAmbr":{"uplink":"100Mbps", "downlink":"100Mbps"},"staticIpAddress":[{"ipv4Addr": "12.1.1.85"}]}}\');' | tee -a $SUB_SQL_FILE
fi

echo "Updating helm charts to use saved credentials for fetching docker images..."
for component in upf udm amf nrf udr lmf nssf ausf smf traffic-server; do
    sed -i 's/# imagePullSecrets:/imagePullSecrets:/' charts/oai-5g-core/oai-${component}/values.yaml
    sed -i 's/#imagePullSecrets:/imagePullSecrets:/' charts/oai-5g-core/oai-${component}/values.yaml
    sed -i 's/#   - name: "regcred"/  - name: "regcred"/' charts/oai-5g-core/oai-${component}/values.yaml
    sed -i 's/#  - name: "regcred"/  - name: "regcred"/' charts/oai-5g-core/oai-${component}/values.yaml
done

echo "Updating helm charts to make traffic generation server pod more permissive..."
sed -i 's/drop:/#drop:/' charts/oai-5g-core/oai-traffic-server/values.yaml
sed -i 's/ - ALL/# - ALL/' charts/oai-5g-core/oai-traffic-server/values.yaml

echo "Deploying the core..."
# Navigate to core charts
cd ~/oai-cn5g-fed/charts/oai-5g-core

# Update dependencies
helm dependency update oai-5g-basic

# Deploy complete 5G core
helm install basic oai-5g-basic/ -n oai-tutorial

echo "Waiting for all core components..."
kubectl wait -n oai-tutorial --for=condition=ready pod -l app.kubernetes.io/instance=basic --timeout=3m