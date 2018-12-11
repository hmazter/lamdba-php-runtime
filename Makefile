ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

php72.zip: bootstrap build.sh php.ini
	docker run --rm -v `pwd`:/opt/layer lambci/lambda:build-provided /opt/layer/build.sh

publish: php72.zip
	./publish.sh

clean:
	rm php72.zip