var CONFIG = require('./config/site');
var express = require('express');
var mail = require('nodemailer').mail;
var jade = require('jade');

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
    mail({
      from: params.from+' <'+params.email+'>',
      to: CONFIG.email,
      bcc: CONFIG.emailDeveloper,
      subject: 'Website Contact Form',
      html: html,
      generateTextFromHTML: true
    });
    res.json({});
  });
});

app.listen(8000);
console.log('Running');