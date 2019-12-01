docker build -t ferastamimi95/multi-client:latest -t ferastamimi95/multi-client:$SHA -f .client/Dockerfile ./client
docker build -t ferastamimi95/multi-server:latest -t ferastamimi95/multi-server:$SHA -f .server/Dockerfile ./server
docker build -t ferastamimi95/multi-worker:latest -t ferastamimi95/multi-worker:$SHA -f .worker/Dockerfile ./worker

docker push ferastamimi95/multi-client:latest
docker push ferastamimi95/multi-server:latest
docker push ferastamimi95/multi-worker:latest

docker push ferastamimi95/multi-client:$SHA
docker push ferastamimi95/multi-server:$SHA
docker push ferastamimi95/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ferastamimi95/multi-server:$SHA
kubectl set image deployments/client-deployment client=ferastamimi95/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ferastamimi95/multi-server:$SHA