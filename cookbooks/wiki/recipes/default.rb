def env_assert(n)
    if not ENV[n]
        abort "you need to specify #{n} as an environment variable."
    end
end

env_assert('RHL_WIKI_DB_PASSWORD')
env_assert('RHL_WIKI_SECRET_KEY')

package 'apache2'

link "/etc/apache2/mods-enabled/ssl.conf" do
  to "/etc/apache2/mods-available/ssl.conf"
end

link "/etc/apache2/mods-enabled/ssl.load" do
  to "/etc/apache2/mods-available/ssl.load"
end

cookbook_file "/etc/apache2/sites-enabled/roguehacklab.com.conf" do
  source "roguehacklab.com.conf"
  mode "0644"
  owner "root"
  group "root"
end

file "/etc/apache2/roguehacklab.crt" do
  content <<END
-----BEGIN CERTIFICATE-----
MIIFJjCCBA6gAwIBAgIDB06GMA0GCSqGSIb3DQEBBQUAMDwxCzAJBgNVBAYTAlVT
MRcwFQYDVQQKEw5HZW9UcnVzdCwgSW5jLjEUMBIGA1UEAxMLUmFwaWRTU0wgQ0Ew
HhcNMTIwNzA5MTUxNjM1WhcNMTMwNzEyMDQwNTA4WjCBvzEpMCcGA1UEBRMgNHZX
L1MwS3IzdkVPMlFBaUstdGdBZGpNYnRJd3BRUi0xEzARBgNVBAsTCkdUMjk1NzU4
NTAxMTAvBgNVBAsTKFNlZSB3d3cucmFwaWRzc2wuY29tL3Jlc291cmNlcy9jcHMg
KGMpMTIxLzAtBgNVBAsTJkRvbWFpbiBDb250cm9sIFZhbGlkYXRlZCAtIFJhcGlk
U1NMKFIpMRkwFwYDVQQDExByb2d1ZWhhY2tsYWIuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEArU32vd2Ow6dMQJt7HgJOagaXCbwN8M5vazScd++t
ZMuGO2sNZBXWDyw9eD5PftpApIp8q3SPwZbq77RxmqY8L/eZITDmoQKje2+w1v1m
KnWVDYzGK43WfuzxAJeb0n9dWGp327BL1Vq/qBU5TqZK8x1KKVgl8JDaDgaWcHtC
jVRjDv3rIAnnlCnAejV5uu4dKLEQJcBTC83VOI+kr+wf0rb2OulEDI7RYsmyatT+
WVvZKlDAudyF6bqWJYIRVR2dXBZnXf0TJVJIbW1TRYAbUdvplqTxv8EvlEfpcPtA
OeP/K1tfyO6WrGsQW6UINqffUnOq+QjUoiqUkEUkRxeYfwIDAQABo4IBqzCCAacw
HwYDVR0jBBgwFoAUa2k9ahhCSt2PAmU5/TUkhniRFjAwDgYDVR0PAQH/BAQDAgWg
MB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAbBgNVHREEFDASghByb2d1
ZWhhY2tsYWIuY29tMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9yYXBpZHNzbC1j
cmwuZ2VvdHJ1c3QuY29tL2NybHMvcmFwaWRzc2wuY3JsMB0GA1UdDgQWBBTkzYeL
iBTmnRVL33ZpP7wKzuGJozAMBgNVHRMBAf8EAjAAMHgGCCsGAQUFBwEBBGwwajAt
BggrBgEFBQcwAYYhaHR0cDovL3JhcGlkc3NsLW9jc3AuZ2VvdHJ1c3QuY29tMDkG
CCsGAQUFBzAChi1odHRwOi8vcmFwaWRzc2wtYWlhLmdlb3RydXN0LmNvbS9yYXBp
ZHNzbC5jcnQwTAYDVR0gBEUwQzBBBgpghkgBhvhFAQc2MDMwMQYIKwYBBQUHAgEW
JWh0dHA6Ly93d3cuZ2VvdHJ1c3QuY29tL3Jlc291cmNlcy9jcHMwDQYJKoZIhvcN
AQEFBQADggEBAAXzgQz+nJHQ7pdeTwEwZXM7ehfvGj8LM2sUz97noYgrX0YlT/wN
cXXcQ7InLypTd6tID4Maw3Jg28FkpRVDVGnb9KN0lnwgebFoQeEDkcbyVmPAEaZz
NNPhxRYeGQfQpNqVZIt70y1w+IgKT+aNpq2S6XgiFBgMCv58FenvbOk/RQxfNdb2
WQyWiog/5nGtNHp6oh6zDQyvWgoWAl1ewTUXqUJCOo7C6aXBMzwMYaVU4FTL3nHT
pdPSdgDCj0tkO6YjeR8oBlS0s8HPwo84lNWDBVZ2uBzs3iuTJW+dzBgGChKWL73d
6tDlw3BV9bjQ6B5lkTwgn433++jeVujDzEU=
-----END CERTIFICATE-----
END
end

file "/etc/apache2/roguehacklab.intermediate.crt" do
  content <<END
-----BEGIN CERTIFICATE-----
MIID1TCCAr2gAwIBAgIDAjbRMA0GCSqGSIb3DQEBBQUAMEIxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1HZW9UcnVzdCBJbmMuMRswGQYDVQQDExJHZW9UcnVzdCBHbG9i
YWwgQ0EwHhcNMTAwMjE5MjI0NTA1WhcNMjAwMjE4MjI0NTA1WjA8MQswCQYDVQQG
EwJVUzEXMBUGA1UEChMOR2VvVHJ1c3QsIEluYy4xFDASBgNVBAMTC1JhcGlkU1NM
IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx3H4Vsce2cy1rfa0
l6P7oeYLUF9QqjraD/w9KSRDxhApwfxVQHLuverfn7ZB9EhLyG7+T1cSi1v6kt1e
6K3z8Buxe037z/3R5fjj3Of1c3/fAUnPjFbBvTfjW761T4uL8NpPx+PdVUdp3/Jb
ewdPPeWsIcHIHXro5/YPoar1b96oZU8QiZwD84l6pV4BcjPtqelaHnnzh8jfyMX8
N8iamte4dsywPuf95lTq319SQXhZV63xEtZ/vNWfcNMFbPqjfWdY3SZiHTGSDHl5
HI7PynvBZq+odEj7joLCniyZXHstXZu8W1eefDp6E63yoxhbK1kPzVw662gzxigd
gtFQiwIDAQABo4HZMIHWMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUa2k9ahhC
St2PAmU5/TUkhniRFjAwHwYDVR0jBBgwFoAUwHqYaI2J+6sFZAwRfap9ZbjKzE4w
EgYDVR0TAQH/BAgwBgEB/wIBADA6BgNVHR8EMzAxMC+gLaArhilodHRwOi8vY3Js
Lmdlb3RydXN0LmNvbS9jcmxzL2d0Z2xvYmFsLmNybDA0BggrBgEFBQcBAQQoMCYw
JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmdlb3RydXN0LmNvbTANBgkqhkiG9w0B
AQUFAAOCAQEAq7y8Cl0YlOPBscOoTFXWvrSY8e48HM3P8yQkXJYDJ1j8Nq6iL4/x
/torAsMzvcjdSCIrYA+lAxD9d/jQ7ZZnT/3qRyBwVNypDFV+4ZYlitm12ldKvo2O
SUNjpWxOJ4cl61tt/qJ/OCjgNqutOaWlYsS3XFgsql0BYKZiZ6PAx2Ij9OdsRu61
04BqIhPSLT90T+qvjF+0OJzbrs6vhB6m9jRRWXnT43XcvNfzc9+S7NIgWW+c+5X4
knYYCnwPLKbK3opie9jzzl9ovY8+wXS7FXI6FoOpC+ZNmZzYV+yoAVHHb1c0XqtK
LEL2TxyJeN4mTvVvk0wVaydWTQBUbHq3tw==
-----END CERTIFICATE-----
END
end

file "/etc/apache2/roguehacklab.key" do
  content <<END
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: DES-EDE3-CBC,1796C5A1D8FD48CA

5NgAKloskP89UFGKz1voA86ZWnkdzEa4UL6qoRwAaSR/Sa7T2zpCJfJODM1tfsWf
uqJNNj/bd3EoDy+AVogmMQFEnEGz2c8ObR5H0X1/isE4PWkp66HzFacxBEJfpnPG
xbpuM+yqQTIwS+ntNF+0TnwlK9mtPhPPknysshShsYcK7KypT7nnKhQ5h7guCdM7
Y0mEiQqVGVl4DCJQngw0Pt1bISwSZMjb5o7BupwBEK5bqu+6pIfH2+pKoVgN7h5Q
/P5+bjxKRUkK6oHRyYEc+PzimWuu30c3mTtxSA0aTk3+gZUVvNKxvbEta/BC3/jO
1+Y0YZq7Dp9mTb9A65sizHcjwuvBwcICWXG0G3X4tmEj28KMW4FYLGRJsSUK8oF5
fZHydZsJ49rkiICKcTGfxbLmBpjJbe9cWyp2rAODwifxqWE2tvN+tixaf7me15wm
lwkIuPBFfOfUTETxvgBW62Nbmk5RIID65fIs1pFD6YOzKYMW0tm6Xx9h9EzTokAy
7OFIgGjesvuYKnY8PactUdkwVaMgL+900sjBixoFYRTRBq5FsimNzuEIS+cgowVX
vT7OhNYhkmfJtyIMUylyq7NtP7yIYVcyY5DaSrIzUEMaw1QmCThEa6A4/Ntu/bx+
O9Ymiv2ShJvwUg5RFQezcuibwsJCEkWntdLdx20iMqkBdgtovWwoWCsOKnZ6F+NN
AaHgmmpYIPFG/gSa3lhNDvdlIasvl2qH58hpYsEDuO9gWUyt5HIE00OxRei8A6T3
5fkWRJKdypAaDSJPHVL+pw9Y7o4e7NL7HWCd9WtBuoVmt9uJHk4gw3IgYQop221v
+o+qOfJPub8IDTnyw0s5+2jHJSPPZrpE1DcenUHf1tfdQJLmyNcczdefftAMAfys
13b/6H8sO7sV1lKiUSBbsvPs8lcZneEzyR+9ExuodtL8Q+71Bsqyfs0OO1z9xWjU
cJUkbSuDKJ+fmHigzYFf/+iMTgAFn5bvGyq/BGVYaV3U97+1MwEBG93cK2iiZEsg
QqXzNIlrPLmYXNqt7B9gCcMwow2w1XbLAgF8/8u9v+eQuhC9PmK92ceyL+EP0d6T
z/XL8eZleD5kaA4XI5kN+Ar0g3ZyQL6aWhRsYTbPO9aF09UYg5D3PdDxRiE233Q/
tisLOiTHOfbS1G/Ja/3d90dEl3+hXYteiAUsDLoARsFvGnc2fc9omDMidX/h02VV
BXBeDwI5nzST9YQa4CV/Wl/EeLtgNAs99tJaCqOBb1sekmw0Ao4DLB2kr1boOH/9
siOR97vLj0yRFBbTsPUpaQHQJI0PbQwJIKkODFtCPf9/p9pELR1fyklh1WrORoJy
+aP6nzcvm6FjVN3zYDZM7UMX1PfGFriQABVYV+ZTsiYMHoRxMhTzZRrUqGFBg+UN
FIY+mDxQ3y4QxzQQHB57LwJh3X+pFbeldrHzSWJ+T6zWOBFlRFrA4HwY9YirLLMb
GiBAYwdOKzsRkhLIKPZBUDEAF3+tBU7/XPhZbaFVAzMQKjFzjYfjYjeT/8pjJQOL
+GCv327NGk7Z2KGSZ4kOgNnS5uSsfvTbRAtHnGI0ZNrQZCMW3NUamzlmhOEDwpn5
-----END RSA PRIVATE KEY-----
END
end

package "mediawiki"

script "create mediawiki database" do
  not_if "test -d /var/lib/mysql/wikidb"
  interpreter "bash"
  code <<END_CODE
    (echo "create database wikidb;";
     echo "grant index, create, select, insert, update, delete, alter, lock tables on wikidb.* to '${RHL_WIKI_DB_USER}'@'localhost' identified by '${RHL_WIKI_DB_PASSWORD}';";) | mysql -u root
END_CODE
end

script "initial mediawiki install" do
  not_if "test -f /etc/mediawiki/LocalSettings.php"
  interpreter "bash"
  code <<END_CODE
    php /var/lib/mediawiki/maintenance/install.php --dbname wikidb --dbtype mysql --dbuser ${RHL_WIKI_DB_USER} --dbpass ${RHL_WIKI_DB_PASSWORD} --scriptpath /mediawiki --pass ${RHL_WIKI_ADMIN_PASSWORD} "Rogue Hack Lab wiki" roguehacklab ${RHL_WIKI_ADMIN_USER}
END_CODE
end

template "/etc/mediawiki/LocalSettings.php" do
  owner "www-data"
  group "www-data"
  mode "0600"
  source "LocalSettings.php"
end

def mediawiki_extension(x, f)
    cookbook_file "/var/lib/mediawiki/extensions/#{f}"

    script "install #{x}" do
        not_if "test -d /var/lib/mediawiki/extensions/#{x}"
        interpreter "bash"
        code <<END_CODE
cd /var/lib/mediawiki/extensions
tar -xzvf #{f}
ln -fs `ls -1 /var/lib/mediawiki/extensions/#{f} | sed -e 's/.tar.gz//'` /var/lib/mediawiki/extensions/#{x}
END_CODE
    end
end

mediawiki_extension "ConfirmEdit", "wikimedia-mediawiki-extensions-ConfirmEdit-6b867ba.tar.gz"
mediawiki_extension "SpamBlacklist", "wikimedia-mediawiki-extensions-SpamBlacklist-72c8bfb.tar.gz"
mediawiki_extension "SimpleAntiSpam", "wikimedia-mediawiki-extensions-SimpleAntiSpam-559827c.tar.gz"
mediawiki_extension "Nuke", "wikimedia-mediawiki-extensions-Nuke-adb67fe.tar.gz"

cookbook_file "/var/lib/mediawiki/images/invader_orange_trans_155x155.png" do
  owner "www-data"
  group "www-data"
  mode "0644"
end

cookbook_file "/var/lib/mediawiki/favicon.ico" do
  owner "www-data"
  group "www-data"
  mode "0644"
end
