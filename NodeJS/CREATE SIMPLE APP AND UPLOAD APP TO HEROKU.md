# CREATE SIMPLE APP AND UPLOAD APP TO HEROKU

## STEP 01 - INSTALL DEPENDENCIES

```bash
npm install express --save
npm install body-parser --save
npm install cookie-parser --save
npm install multer --save
```

## STEP 02 - CREATE FOLDER PUBLIC

## STEP 03 - CREATE FILE SERVER.JS - EXAMPLE SCRIPT

```node
var express = require("express");
var app = express();
var PORT = process.env.PORT || 8080;

app.use(express.static("public"));

app.get("/", function (req, res) {
  res.send(JSON.stringify({ Hello: "World" }));
});

app.use((req, res, next) => {
  const error = new Error("NOT FOUND");
  error.status = 404;
  next(error);
});

app.listen(PORT, function () {
  console.log("APP LISTENING ON PORT " + PORT);
});
```

## STEP 04 - INIT NPM AND GIT, CONNECT GIT LOCAL TO HEROKU GIT, UPLOAD APP TO HEROKU

```bash
npm init
git init
heroku git:remote -a Hello_World
git add .
git commit -am "Initial commit"
git push heroku master
```

## STEP 05 - UPDATE APP TO HEROKU

```bash
heroku git:remote -a Hello_World
git add .
git commit -am "Update app"
git push heroku master
```

## STEP 06 - OPEN HEROKU LOG

```bash
heroku logs --tail
```
