const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

app.post('/analyze',(req,res) => {
    // AI評価ロジック
    res.json({ rating: 'A'});
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});