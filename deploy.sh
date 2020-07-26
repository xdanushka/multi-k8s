docker build -t danushkarmdc/multi-client:latest -t danushkarmdc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danushkarmdc/multi-server:latest -t danushkarmdc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danushkarmdc/multi-worker:latest -t danushkarmdc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push danushkarmdc/multi-client:latest
docker push danushkarmdc/multi-server:latest
docker push danushkarmdc/multi-worker:latest

docker push danushkarmdc/multi-client:$SHA
docker push danushkarmdc/multi-server:$SHA
docker push danushkarmdc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danushkarmdc/multi-server:$SHA
kubectl set image deployments/client-deployment client=danushkarmdc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=danushkarmdc/multi-worker:$SHA