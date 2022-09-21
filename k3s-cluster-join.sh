echo "Enter your token to join a cluster"
read SECRET 
echo "Enter the ip for the master of the cluster"
read ipToMaster

if [[ $SECRET = "" ]] || [[ $ipToMaster = "" ]]
then
echo "Token or IP was left empty try running the script again"
exit 1
else
curl -sfL https://get.k3s.io | K3S_TOKEN=$SECRET sh -s - server --server https://$ipToMaster:6443
fi
