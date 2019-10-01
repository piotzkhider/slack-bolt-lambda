'use strict';

const { App, ExpressReceiver } = require('@slack/bolt');
const expressReceiver = new ExpressReceiver({
  signingSecret: process.env.SLACK_SIGNING_SECRET,
});
const app = new App({
  token: process.env.SLACK_BOT_TOKEN,
  receiver: expressReceiver,
});
module.exports = expressReceiver.app;

app.command('/ping', async ({ ack, say }) => {
  ack();

  say('pong');
});
