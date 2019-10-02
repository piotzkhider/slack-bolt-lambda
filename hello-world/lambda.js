const { createServer, proxy } = require('aws-serverless-express');
const app = require('./app');

exports.handler = (event, context, callback) => {
  const server = createServer(app);

  context.succeed = response => {
    server.close();
    callback(null, response);
  };

  return proxy(server, event, context);
};
