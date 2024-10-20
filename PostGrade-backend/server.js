const express = require('express');
const axios = require('axios');
const cors = require('cors');
const port = 3000;

const app = express();
app.use(express.json());
app.use(cors());

// ChatGPT APIキー
const OPENAI_API_KEY = 'your-openai-api-key';

app.get('/', (req, res) => {
  res.send('Hello from Node.js Server!');
});

// 投稿の評価を行うエンドポイント
app.post('/ratePost', async (req, res) => {
  const { content } = req.body;

  // リクエストボディからコンテンツを取得し、バリデーションを行う
  if (!content) {
    return res.status(400).json({ error: 'Content is required' });
  }

  try {
    const { content } = req.body;

    // リクエストボディからコンテンツを取得し、バリデーションを行う
    if (!content) {
      return res.status(400).json({ error: 'Content is required' });
    }
  
    // A〜Cからランダムに評価を生成
    const ratings = ['A', 'B', 'C'];
    const randomRating = ratings[Math.floor(Math.random() * ratings.length)];
  
    // 評価をJSON形式で返す
    res.json({ rating: randomRating });
    // // OpenAI APIにリクエストを送信して評価を取得
    // const response = await axios.post(
    //   'https://api.openai.com/v1/completions',
    //   {
    //     model: 'text-davinci-003',
    //     prompt: `Evaluate the following post and give a rating between A to D. If the post cannot be evaluated, return F: ${content}`,
    //     max_tokens: 50,
    //   },
    //   {
    //     headers: {
    //       'Content-Type': 'application/json',
    //       Authorization: `Bearer ${OPENAI_API_KEY}`,
    //     },
    //   }
    // );

    // // レスポンスから評価を取得
    // let rating = response.data.choices[0].text.trim();

    // // A〜F以外の評価の場合、Fに設定
    // if (!['A', 'B', 'C', 'D', 'E', 'F'].includes(rating)) {
    //   rating = 'F';
    // }

    // 評価をJSON形式で返す
    // res.json({ rating });
  } catch (error) {
    console.error('Error calling OpenAI API:', error); // エラーをログに記録
    res.status(500).json({ error: 'Failed to get rating from ChatGPT' });
  }
});

// サーバーを指定したポートでリスニングする
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
