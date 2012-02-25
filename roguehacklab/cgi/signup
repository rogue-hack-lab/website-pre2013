#!/usr/bin/env python
import cgi
import cgitb
cgitb.enable()

form = cgi.FieldStorage()

pagehtml = ''' <html>
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
        <li><a href="/index.html">home</a></li>
        <li><a href="/members.html">member list</a></li>
        <li><a href="/about.html">about</a></li>
        <li><a href="/join.html">join</a></li>
        <li><a href="/news.html">news</a></li>
      </ul>
    </div>
    <div id='content'>
        %s
    </div>
</body>
</html>
'''

email = cgi.escape(form["email"].value)
content = "<p>Added: %s </p>" % email

fn = '/tmp/signups.txt'
try:
    open(fn, 'a').write('%s\n' % email)
except:
    content = 'There was some sort of problem adding your email, sorry. If you could shoot us an email and let us know that would be great.'

print "Content-Type: text/html\n\n"
print pagehtml % content

