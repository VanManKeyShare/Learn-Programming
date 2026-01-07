//
// JS -> REMOVE ALL TAGS FROM HTML WITH REGEX

var DATA = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Example</title>
    <link rel="stylesheet" href="/abc.css" />
    <style>
        body {
            background-color: red;
        }
    </style>
</head>
<body>
    <img src="/abc.png" />
</body>
</html>`;

DATA = DATA.replaceAll(/\r\n/g, "");
DATA = DATA.replaceAll(/\r/g, "");
DATA = DATA.replaceAll(/\n/g, "");

var REMOVE_HEAD_TAG = /<head\b[^<]*(?:(?!<\/head>)<[^<]*)*<\/head>/gi;
DATA = DATA.replace(REMOVE_HEAD_TAG, "");

var REMOVE_SCRIPT_TAG = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
DATA = DATA.replace(REMOVE_SCRIPT_TAG, "");

var REMOVE_LINK_TAG = /<link(.*?)>/gi;
DATA = DATA.replace(REMOVE_LINK_TAG, "");

var REMOVE_STYLE_TAG = /<style\b[^<]*(?:(?!<\/style>)<[^<]*)*<\/style>/gi;
DATA = DATA.replace(REMOVE_STYLE_TAG, "");

var REMOVE_IMG_TAG = /<img(.*?)>/gi;
DATA = DATA.replace(REMOVE_IMG_TAG, "");
