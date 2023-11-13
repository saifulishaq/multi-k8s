docker build -t saifulishaq/multi-client:latest -t saifulishaq/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saifulishaq/multi-server:latest -t saifulishaq/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saifulishaq/multi-worker:latest -t saifulishaq/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push saifulishaq/multi-client:latest
docker push saifulishaq/multi-server:latest
docker push saifulishaq/multi-worker:latest

docker push saifulishaq/multi-client:$SHA
docker push saifulishaq/multi-server:$SHA
docker push saifulishaq/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployment/server-deployment server=saifulishaq/multi-server:$SHA
kubectl set image deployment/client-deployment client=saifulishaq/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=saifulishaq/multi-worker:$SHA