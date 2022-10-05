SECRET=$1 
ipToMaster=$2

if [ -z "$ipToMaster" ] || [ -z "$SECRET" ]
then
echo "Token or IP was left empty try running the script again"
exit 1
else
curl -sfL https://get.k3s.io | K3S_TOKEN=$SECRET sh -s - server --server https://$ipToMaster:6443 --disable traefik
fi
