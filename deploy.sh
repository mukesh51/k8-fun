docker build -t mukesh51/multi-client:latest -t mukesh51/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mukesh51/multi-server:latest -t mukesh51/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mukesh51/multi-worker:latest -t mukesh51/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mukesh51/multi-client:latest
docker push mukesh51/multi-server:latest
docker push mukesh51/multi-worker:latest

docker push mukesh51/multi-client:$SHA
docker push mukesh51/multi-server:$SHA
docker push mukesh51/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mukesh51/multi-server:$SHA
kubectl set image deployments/client-deployment client=mukesh51/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mukesh51/multi-worker:$SHA