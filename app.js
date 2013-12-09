var CONFIG = require('./config/site');
var express = require('express');
var email = require('emailjs');
var server  = email.server.connect({host: "localhost"});
var app = express();

app.use(express.static(__dirname + '/public'))
app.use(express.urlencoded());
app.use(express.json());
app.post('/contact', function (req, res) {

  var params = req.body;
  var mail = {
    to: CONFIG.email,
    from: params.from+' <'+params.email+'>',
    subject: 'Website Contact Form',
    text: params.message
  };
  server.send(mail, function(err, msg) {
    res.redirect('/');
  });

});

app.listen(8000);