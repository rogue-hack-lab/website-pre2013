import cgi

from google.appengine.ext import db
from google.appengine.api import users
from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app
from google.appengine.api import mail


class SignupEmail(db.Model):
  email = db.StringProperty()
  date = db.DateTimeProperty(auto_now_add=True)

authemails = ['fran.bull@gmail.com']

pagehtml = '''
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Rogue Hack Lab</title>
    <link rel="stylesheet" href="styles/base.css" type="text/css" />
  </head>    
<body>
    <div id="header">
        <h1>Rogue Hack Lab</h1>
    </div>
    <div id="navigation">
      <ul>
        <li><a href="index.html">home</a></li>
        <li><a href="members.html">member list</a></li>
        <li><a href="about.html">about</a></li>
        <li><a href="join.html">join</a></li>
        <li><a href="news.html">news</a></li>
      </ul>
    </div>
    <div id='content'>
        %s
    </div>
</body>
</html>
'''


class Signup(webapp.RequestHandler):
    def post(self):
        email = cgi.escape(self.request.get('email'))
        content = """ok, we will send emails to:
        <pre>
            %s
        </pre>""" % email
        self.response.out.write(pagehtml % content)    
        suemail = SignupEmail()
        suemail.email = email
        suemail.put()
        self.emailus(email)
        
    def emailus(self, newmail):
        mail.send_mail(sender="fran.bull@gmail.com",
              to="fran.bull@gmail.com",
              subject="Sign up at roguehacklab",
              body="""
Someone signed up at rogue hack lab with email:
%s

""" % newmail)
        
class ListSignup(webapp.RequestHandler):
    def get(self):
        user = users.get_current_user()

        if not user:
            self.redirect(users.create_login_url(self.request.uri))
        if user.email() not in authemails:
            self.response.out.write(pagehtml % 'There is nothing here.')
        else:
            signups = db.GqlQuery("SELECT * FROM SignupEmail")
            l = '<ul>'
            for s in signups:
                l += '<li>%s</li>' % s.email
            l += '</ul>'
            self.response.out.write(pagehtml % l)

application = webapp.WSGIApplication([
  ('/signup', Signup),
  ('/listsignups', ListSignup),
], debug=True)


def main():
  run_wsgi_app(application)