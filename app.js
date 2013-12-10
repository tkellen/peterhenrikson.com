var CONFIG = require('./config/site');
var AUTH = require('./config/auth');
var express = require('express');
var nodemailer = require('nodemailer');
var jade = require('jade');
var gmail = nodemailer.createTransport("SMTP", {
   service: "Gmail",
   auth: {
       user: AUTH.email.user,
       pass: AUTH.email.pass
   }
});

var app = express();

app.configure('development', function () {
  app.use('/site',express.static(__dirname+'/site'));
  app.use('/config',express.static(__dirname+'/config'));
  app.use('/components',express.static(__dirname+'/components'));
  app.use(express.static(__dirname + '/public'));
});

app.configure(function () {
  app.engine('jade', jade.__express);
  app.set('views',__dirname+'/site/views');
  app.use(express.static(__dirname + '/public'))
  app.use(express.urlencoded());
  app.use(express.json());
});

app.post('/contact', function (req, res) {
  var params = req.body
  app.render('emails/contact.jade', params, function(err, html) {
    gmail.sendMail({
      from: params.from+' <'+params.email+'>',
      to: CONFIG.email,
      bcc: CONFIG.emailDeveloper,
      subject: 'Website Contact Form',
      html: html,
      generateTextFromHTML: true
    }, function () {
      res.json({});
    });
  });
});

app.listen(8000);
console.log('Running');