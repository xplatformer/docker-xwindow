include Makefile.file.variable
include Makefile.metadata.variable

#======================== 
# Global Variables
#======================== 
DEFAULT_VERSION := -no-version-set-
VERSION ?= $(DEFAULT_VERSION)
TAG_SUFFIX ?=
TAG_PREFIX ?=
BUILD_PARAMETERS =

include $(PATH_INFO)/Makefile.*.variable

#======================== 
# Rule Validation
#======================== 
RULES := image build test pull push release deploy inspect-%
ifneq (,$(filter $(RULES),$(MAKECMDGOALS)))
ifeq ($(VERSION),$(DEFAULT_VERSION))
$(error The version is not properly set for the command (make VERSION=<-> COMMAND))
endif
ifeq (,$(wildcard $(PATH_DOCKER)))
$(error The version [$(VERSION)] is not valid for this image.  See versions/ for possible image versions)
endif
ifeq (,$(wildcard $(PATH_OPTIONS)))
$(error The version [$(VERSION)] is incorrectly setup and does not have a 'Makefile.options')
endif
include $(PATH_OPTIONS)
endif

ifeq (,$(wildcard $(PATH_IMAGEFILE)))
$(error The docker image is defined in 'info/')
endif
include $(PATH_IMAGEFILE)

ifeq (,$(wildcard $(PATH_VERSIONFILE)))
$(error The version of the docker image is not present in 'info/')
endif

#======================== 
# Image Variables
#======================== 
STAGING_REGISTRY ?= $(REGISTRY)
STAGING_NAMESPACE ?= $(NAMESPACE)
STAGING_PROJECT ?= $(PROJECT)

IMAGE := ${REGISTRY}/${NAMESPACE}/${PROJECT}
STAGING_IMAGE := ${STAGING_REGISTRY}/${STAGING_NAMESPACE}/${STAGING_PROJECT}
WORKING_IMAGE ?= $(STAGING_IMAGE):$(TAG_PREFIX)$(TAG)$(TAG_SUFFIX)

##======================== 
## Rules
##======================== 

.PHONY: build test prune purge clean debug pull push release image inspect-% info debug check-env help
.DEFAULT_GOAL := help


#======================== 
# Output Rules
#======================== 

help:
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

debug-% : ; @echo $* = $($*)

info: ## Prints a collection of vital project variables.
	@echo Image Version: $(VERSION)
	@echo CODE_VERSION = $(CODE_VERSION)
	@echo GIT_COMMIT = $(GIT_COMMIT)
	@echo BUILD_DATE = $(BUILD_DATE)
	@echo Working Image: $(WORKING_IMAGE)
	@echo
	@echo Registry:
	@echo IMAGE = $(IMAGE)
	@echo STAGING_IMAGE = $(STAGING_IMAGE)	
	@echo
	@echo Pathing:
	@echo PATH_DOCKER: $(PATH_DOCKER)
	@echo PATH_DOCKERFILE: $(PATH_DOCKERFILE)
	@echo PATH_BUILD = $(PATH_BUILD)
	@echo PATH_ROOT = $(PATH_ROOT)
	@echo PATH_VERSIONS = $(PATH_VERSIONS)
	@echo PATH_TESTS = $(PATH_TESTS)
	@echo
	@echo Versions:
	@echo $(shell ls ${PATH_VERSIONS} | tr "\n" " ")

#======================== 
# Docker Rules
#======================== 

prune: ## Remove all unused images (both dangling and unreferenced).
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

clean: ## Remove one or more tags of the image.
	docker images | grep $(STAGING_NAMESPACE)/$(STAGING_PROJECT) | tr -s ' ' | cut -d ' ' -f 3 | xargs --no-run-if-empty docker rmi


purge: ## Remove all unused containers and images (both dangling and unreferenced).
	docker ps -qa | xargs --no-run-if-empty docker rm -fv
	docker images -qa | xargs --no-run-if-empty docker rmi -f

pull: check-version check-tag ## Pull the working docker image from a registry.
	docker pull $(WORKING_IMAGE)

push: check-version check-tag ## Push the working docker image to a registry.
	docker push $(WORKING_IMAGE)

release: check-version check-tag ## Tag the working image as a release image.
	docker tag $(WORKING_IMAGE) $(IMAGE):$(TAG)

deploy: check-version check-tag ## Push the docker image to a registry.
	docker push $(IMAGE):$(TAG)

#======================== 
# Build Rules
#======================== 

inspect-% : check-version check-tag ; @echo $* = $($*) ## Prints the variable value for a image version.

image: check-version check-tag ## Prints the working name of the image. 
	@echo $(WORKING_IMAGE)

build: check-path check-tag ## Build an image for a specific version.
	docker build --pull \
		 -t $(WORKING_IMAGE) \
		 \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${CODE_VERSION}" \
		--build-arg VCS_REF="${GIT_COMMIT}" \
		\
		$(BUILD_PARAMS) \
		\
		-f $(PATH_DOCKERFILE) $(PATH_DOCKER)/. \

#======================== 
# Test Rules
#======================== 

test: check-version check-tag check-test ## Test an image for a specific version.
	@echo Running '$(VERSION)' tests on $(WORKING_IMAGE).
	docker run --rm --privileged \
		-v $(MOUNT_TESTS):/media --workdir /media \
		-e DOCKER_IMAGE_NAME=$(WORKING_IMAGE) \
		-e DOCKER_PATH=$(MOUNT_TESTS) \
		\
		-v /var/run/docker.sock:/docker.sock \
		-e DOCKER_HOST="unix:///docker.sock" \
		\
		jrbeverly/dind-bats bats $(VERSION).bash

#======================== 
# Validation
#======================== 

# Ensures that the test path is valid
check-test:
ifeq (,$(wildcard $(PATH_DOCKER_TEST)))
	$(error The testing for version [$(VERSION)] is not valid for this image.  See tests/test/ for possible image versions [$(PATH_DOCKER_TEST)])
endif

# Ensures that the tag is set
check-tag:
ifndef TAG
	$(error The version [$(VERSION)] is incorrectly setup and does not have a 'TAG' variable)
endif

# Ensures that the version is set
check-version:
ifeq ($(VERSION),$(DEFAULT_VERSION))
	$(error The version is not properly set for the command (make VERSION=<-> COMMAND))
endif

# Ensures that the paths are valid
check-path:
ifeq (,$(wildcard $(PATH_DOCKER)))
	$(error The provided docker path is not valid for this image.  See versions/ for possible image versions [$(PATH_DOCKER)])
endif
ifeq (,$(wildcard $(PATH_DOCKERFILE)))
	$(error A dockerfile could not be found at the path $(PATH_DOCKERFILE))
endif
