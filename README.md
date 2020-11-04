# test1-api
Test 1 Simple Web API

## Development Prerequisites
To test and develop the API locally, the following tools are required:

- docker
- docker-compose
- make

Devlopment and deployment tools follow the 3musketeers pattern - see [3musketeers.io](https://3musketeers.io/)

## Running the API Server Locally
To run the API locally (within a Docker container) execute the following command:

```
make run-local
```

## Test Suite
To run the Mocha-Chai test suite for API, execute the following command:

```
make test
```

## Build and Publish an API Docker Image
To build a new (local) version of a Docker image (with all API code and required modules), execute the following command:

```
make build
```

Images will be tagged with a development version field from `package.json`, eg. test1-api:1.0.0-DEV

To publish the current image to Dockerhub, run the following command:
(Note, this requires a valid Dockerhub login and project rights when running locally)

```
make publish
```

## CI/CD Pipeline Builds (automated)
CI settings for GitLab CI can be found in `.gitlab-ci.yml`

GitLab CI automatically creates DEV and PROD builds when code is pushed to the `development` or `master` branches, respectively.

To generate a new DEV release:

- Update package.json to set the current version (use [Semantic Versioning](https://semver.org/) )
- Raise a merge request against the `development` branch
- Pipeline will build the new images, tagged with version and DEV (eg. 1.0.0-DEV)
- Images will be pushed to dockerhub and ready for use.

To generate a new PROD release (from a final development version):

- Raise a merge request from `development` to `master`
- Merge the request into `master`
- Pipeline will build and publish the release (eg. 1.0.0)
- Image is ready for release to production environment (kubernetes, etc)

## Kubernetes Deployment
An example Kubernetes deployment exists in the `./kube` folder.
The deployment creates a deployment in the default namespace with the folloing resources:

- 3 replicas
- a configmap with environment values
- a service that exposes a load balancer across the pods on port 3000

To deploy the Kubernetes configuration locally, execute the following command:

```
make kube-deploy
```

To destroy the Kube environment, run:

```
make kube-destroy
```

## Contributing
To contribute to the code for API, please follow these guidelines:

- Git clone the latest `development` branch
- Create a local branch for your changes `git checkout -b yourbranch`
- Push your local branch upstream eg. `git push -u origin yourbranch`
- Raise a Merge Request to `development` from your branch
- Ensure your build CI pipeline is passing
- Request merge approval for your code to be accepted into the main development branch.
