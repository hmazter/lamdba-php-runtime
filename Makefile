ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

php71.zip: bootstrap
	docker run --rm -v `pwd`:/opt/layer lambci/lambda:build-provided /opt/layer/build.sh

publish: php71.zip
	./publish.sh

clean:
	rm php71.zip