const express = require('express');
const path = require('path');
const http = require('http');
const app = express();

app.use(express.static('/Users/jmarcum/git/repos/private/codessential/frontend'));
app.get('/', (req, res) => res.sendFile(path.join('/Users/jmarcum/git/repos/private/codessential/frontend/index/.html')));

http.createServer(app).listen(3000);

