# pahud/awscdk-action
`pahud/awscdk-action` is a Github Actions workflow that leverages [pahud/github-codespace](https://github.com/pahud/github-codespace) docker image to help you execute AWS CDK CLI in the workflows.

# Why `pahud/github-codespace` Docker image

[pahud/github-codespace](https://github.com/pahud/github-codespace) uses `jsii/superchain` as the base image, which is the recommended docker base image for aws/aws-cdk(see [Dockerfile](https://github.com/aws/aws-cdk/blob/a4a41b5e006110304b51ee55c34e91cc3f129281/Dockerfile#L1)), and it installs the latest `CDK CLI` as well as `AWS CLI V2` with the Github Action and [publish](https://github.com/pahud/github-codespace/actions?query=workflow%3A%22Publish+Docker+image%22) to docker hub every single hour.

This Github Action leverages this custom docker image to ensure you have the latest **AWS CDK CLI** as well as the **AWS CLI V2**.

# How to use?

Create a GitHub workflow file `.github/workflows/cdkdeploy.yml`

```yaml
on:
  push:
    branches:
      - master
  workflow_dispatch: {}

jobs:
  cdk_jobs:
    runs-on: ubuntu-latest
    name: AWS CDK jobs
    steps:
    - name: version
      id: version
      uses: pahud/awscdk-action@20ec874
      with:
        command: '--version'
    - name: get the version from the output
      run: echo "The version was ${{ steps.version.outputs.version }}"
    - name: diff
      id: diff
      uses: pahud/awscdk-action@20ec874
      with:
        command: 'diff'
    - name: deploy
      id: deploy
      uses: pahud/awscdk-action@20ec874
      with:
        command: 'deploy --require-approval=never'
```
