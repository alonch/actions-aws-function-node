<!-- action-docs-header source="action.yml" -->

<!-- action-docs-header source="action.yml" -->
![Demo Status](https://github.com/alonch/actions-aws-function-node/actions/workflows/on-push.yml/badge.svg)
<!-- action-docs-description source="action.yml" -->
## Description

Provision an AWS function
<!-- action-docs-description source="action.yml" --> 

<!-- action-docs-inputs source="action.yml" -->
## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `action` | <p>Desire outcome: apply, plan or destroy</p> | `false` | `apply` |
| `name` | <p>Function name</p> | `true` | `""` |
| `arm` | <p>Run in ARM compute</p> | `false` | `false` |
| `node-version` | <p>NodeJS version, Supported versions: 16, 18 and 20</p> | `false` | `20` |
| `entrypoint-file` | <p>Path to entry file</p> | `true` | `""` |
| `entrypoint-function` | <p>Function on the <code>entrypoint-file</code> to handle events</p> | `true` | `""` |
| `memory` | <p>128 (in MB) to 10,240 (in MB)</p> | `false` | `128` |
| `env` | <p>List of environment variables in YML format</p> | `false` | `CREATE_BY: alonch/actions-aws-function-node ` |
| `permissions` | <p>List of permissions following Github standard of service: read or write. In YML format</p> | `false` | `""` |
| `artifacts` | <p>This folder will be zip and deploy to Lambda</p> | `false` | `""` |
| `timeout` | <p>Maximum time in seconds before aborting the execution</p> | `false` | `3` |
| `allow-public-access` | <p>Generate a public URL. WARNING: ANYONE ON THE INTERNET CAN RUN THIS FUNCTION</p> | `false` | `""` |
<!-- action-docs-inputs source="action.yml" -->

<!-- action-docs-outputs source="action.yml" -->
## Outputs

| name | description |
| --- | --- |
| `url` | <p>Public accessiable URL, if <code>allow-public-access=true</code> </p> |
| `arn` | <p>AWS Lambda ARN</p> |
<!-- action-docs-outputs source="action.yml" -->

## Sample Usage
```yml
jobs:
  deploy:
    permissions: 
      id-token: write
    runs-on: ubuntu-latest
    steps:
      - name: Check out repo
        uses: actions/checkout@v4
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-region: us-east-1
          role-to-assume: ${{ secrets.ROLE_ARN }}
          role-session-name: ${{ github.actor }}
      - uses: alonch/actions-aws-backend-setup@main
        id: backend
        with: 
          instance: demo
      - uses: alonch/actions-aws-function-node@main
        with: 
          name: actions-aws-function-node-demo
          entrypoint-file: src/index.js
          entrypoint-function: handler
          artifacts: dist
          allow-public-access: true
```

