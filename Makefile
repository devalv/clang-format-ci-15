docker-build:
	docker build . -t devalv/clang-format-15:0.1.1

docker-push:
	docker push devalv/clang-format-15:0.1.1
