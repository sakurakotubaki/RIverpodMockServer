# api_example
ローカル環境にモックサーバーを作りAPIを自作する。

## 環境構築
1. モックサーバーを構築するフォルダを作成する。
```
mkdir mock-api
```
2. package.jsonを生成する
```
npm init -y
```
3. json-serverをインストールする
```
npm install -g json-server
```
4. db.jsonを作成する
```
touch db.json
```
5. ダミーのデータをdb.jsonに作成する
```json
{
  "posts": [
    {
      "id": 1,
    "name": "田中太郎",
    "date": "2023-04-29T13:54:30+00:00"
    },
    {
      "id": 2,
    "name": "山田花子",
    "date": "2023-04-29T13:54:30+00:00"
    },
    {
      "id": 3,
    "name": "佐藤茂雄",
    "date": "2023-04-29T13:54:30+00:00"
    },
    {
      "id": 4,
    "name": "伊藤二郎",
    "date": "2023-04-29T13:54:30+00:00"
    },
  ]
}
```
6. json-serverを起動する
```
json-server --watch db.json
```
こちらのURLにアクセスするとdb.jsonのデータがブラウザに表示される
http://localhost:3000/posts