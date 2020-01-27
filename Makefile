APP_NAME=sawseen/pytorch_cv:mesh_rcnn
CONTAINER_NAME=mesh_rcnn_runtime

build:
	docker build -t $(APP_NAME) -f docker/Dockerfile .

inference: ## Run container for inference
	docker run \
		--privileged \
	    --runtime=nvidia \
		-itd \
		--name=${CONTAINER_NAME} \
		-v $(shell pwd):/center_net \
		-v /home/ivan-sosin/Pictures:/home/ivan-sosin/Pictures \
        -p 6000:6000 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=unix${DISPLAY} \
		$(APP_NAME) bash

exec: ## Run a bash in a running container
	docker exec -it ${CONTAINER_NAME} bash

stop: ## Stop and remove a running container
	docker stop ${CONTAINER_NAME}; docker rm ${CONTAINER_NAME}
