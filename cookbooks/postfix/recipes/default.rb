package "postfix"

cookbook_file "/etc/mailname" do
  source "mailname"
  mode "0644"
  owner "root"
  group "root"
end

cookbook_file "/etc/postfix/main.cf" do
  source "main.cf"
  mode "0644"
  owner "root"
  group "root"
end

cookbook_file "/etc/aliases" do
  source "aliases"
  mode "0644"
  owner "root"
  group "root"
end

script "restart postfix" do
  interpreter "bash"
  code <<END_CODE
newaliases
service postfix restart
END_CODE
end
