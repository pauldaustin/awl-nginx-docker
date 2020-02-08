docker login awldocker.azurecr.io --username=awldocker
docker build -t awldocker.azurecr.io/awl-nginx .
docker push awldocker.azurecr.io/awl-nginx

