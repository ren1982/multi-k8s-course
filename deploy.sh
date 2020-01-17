docker build -t renrobles/multi-client:latest -t renrobles/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t renrobles/multi-server:latest -t renrobles/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t renrobles/multi-worker:latest -t renrobles/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push renrobles/multi-client:latest
docker push renrobles/multi-server:latest
docker push renrobles/multi-worker:latest
docker push renrobles/multi-client:$SHA
docker push renrobles/multi-server:$SHA
docker push renrobles/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=renrobles/multi-server:$SHA
kubectl set image deployments/client-deployment client=renrobles/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=renrobles/multi-worker:$SHA