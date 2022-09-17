echo "enter your join token for the k3s cluster"
read SECRET

if [ $SECRET = "" ]
then
echo "token empty"
exit 1
else
curl -sfL https://get.k3s.io | K3S_TOKEN=$SECRET sh -s - server --cluster-init
clear
echo -e "Use this token to join your other nodes to this cluster \n$SECRET\n"
echo -e "Use the local ip of this master node when running the cluster-join.sh \n"
ip -br a
fi