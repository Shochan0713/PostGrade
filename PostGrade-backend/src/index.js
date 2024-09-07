// src/index.js
const express = require('express');
const db = require('./db');
const app = express();
const port = 3001;

app.use(express.json());

app.post('/analyze', async (req, res) => {
    console.log('Received request:', req.body); // リクエスト内容をログに出力
    const { content } = req.body;
    try {
      const docRef = db.collection('posts').doc();
      await docRef.set({
        content: content,
        rating: 'A'
      });
      res.json({ id: docRef.id, content, rating: 'A' });
    } catch (err) {
      console.error('Error:', err.message); // エラーメッセージをログに出力
      res.status(500).json({ error: err.message });
    }
  });

app.get('/posts', async (req, res) => {
    try {
      const snapshot = await db.collection('posts').get();
      const posts = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
      res.json(posts);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });


app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});