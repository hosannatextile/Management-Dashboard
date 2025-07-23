const express = require('express');
const path = require('path');
const app = express();

const port = process.env.PORT || 3000;
const webPath = path.join(__dirname, 'build/web');

app.use(express.static(webPath));

app.get('*', (req, res) => {
  res.sendFile(path.join(webPath, 'index.html'));
});

app.listen(port, () => {
  console.log("Flutter web app is running on port ${port}");
});