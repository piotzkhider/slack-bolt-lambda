'use strict';

const { createServer, proxy } = require('aws-serverless-express');
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
const app = require('./app');

app.use(awsServerlessExpressMiddleware.eventContext());

exports.handler = (event, context, callback) => {
  const server = createServer(app);

  context.succeed = (response) => {
    server.close();
    callback(null, response);
  };

  return proxy(server, event, context);
};
