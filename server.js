const express = require('express');
const client = require('prom-client');
const app = express();
const port = process.env.PORT || 3000;

const users = [{ id: 1, name: 'Alice' }, { id: 2, name: 'Bob' }];

const register = new client.Registry();
client.collectDefaultMetrics({ register });

const usersCounter = new client.Counter({
  name: 'api_users_requests_total',
  help: 'Total number of requests to /users',
});
register.registerMetric(usersCounter);

app.get('/health', (req, res) => res.send('OK'));

app.get('/users', async (req, res) => {
  await new Promise(resolve => setTimeout(resolve, 5000)); // simulate delay
  usersCounter.inc();
  res.json(users);
});


app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Server running on port ${port}`);
});
