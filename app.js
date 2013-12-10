var CONFIG = require('./config/site');
var express = require('express');
var email = require('emailjs');
var server  = email.server.connect({host:'localhost'});

var app = express();

app.configure('development', function () {
  app.use('/site',express.static(__dirname+'/site'));
  app.use('/config',express.static(__dirname+'/config'));
  app.use('/components',express.static(__dirname+'/components'));
  app.use(express.static(__dirname + '/public'));
});

app.configure(function () {
  app.use(express.static(__dirname + '/public'))
  app.use(express.urlencoded());
  app.use(express.json());
});

app.post('/contact', function (req, res) {

  var params = req.body;
  var mail = {
    to: CONFIG.email,
    from: params.from+' <'+params.email+'>',
    subject: 'Website Contact Form',
    text: params.message
  };
  server.send(mail, function(err, msg) {
    res.json({})
  });

});

app.listen(8000);
console.log('Running');