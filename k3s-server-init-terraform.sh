SECRET=$1

if [ -z "$SECRET" ]
then
echo "token empty"
exit 1
else
curl -sfL https://get.k3s.io | K3S_TOKEN=$SECRET sh -s - server --cluster-init --disable traefik
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update -y
sudo apt-get install helm -y
clear
echo -e "Use this token to join your other nodes to this cluster \n$SECRET\n"
ip -br a
fi
