package "mailman"

cookbook_file "/etc/mailman/mm_cfg.py" do
  source "mm_cfg.py"
  mode "0644"
  owner "root"
  group "root"
end

script "restart mailman" do
  interpreter "bash"
  code <<END_CODE
/etc/init.d/mailman force-reload
END_CODE
end
