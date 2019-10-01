# Slack Bolt powered by API Gateway and Lambda

## Run the app on your local machine

### Expose local servers to the internet

http://serveo.net/

```bash
$ make expose
```

### Create a Slack App

https://api.slack.com/apps

- Create a Slack App
  - Use these information in "App Credentials"
    - Signing Secret
- Add a Slash Command
  - `/ping` command
    - Request URL: `https://{serveo domain}/slack/events`
- Add a Bot user
  - Enable `bot` permission & add a bot user
- Grab OAuth Token
  - Use this token in "Tokens for Your Workspace"
    - Bot User OAuth Access Token
    
```bash
$ vi template.yaml # set SLACK_SIGNING_SECRET, SLACK_BOT_TOKEN
```

```bash
$ make install
$ make local
```

## Deploy the app onto AWS

```bash
$ vi Makefile # set PROFILE, REGION, BUCKET
```

```bash
$ make setup
```

# ref.

* https://github.com/seratch/slack-app-examples/issues/1
* https://github.com/seratch/slack-app-examples/tree/master/serverless-bolt-template/aws-js
* https://github.com/awslabs/serverless-application-model/tree/cbd4d9ad40a71b838f1e72b3b960689f30890bf9/examples/2016-10-31/api_cognito_auth
