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

## Build and Publish an API Docker Image
To build a new version of a Docker image (with all API code and required modules), execute the following command:

```
make build
```

Images will be tagged with a development version field from `package.json`, eg. test1-api:1.0.0-dev

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

