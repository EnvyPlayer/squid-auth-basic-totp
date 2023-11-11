# squid-auth-basic-totp

Depends on:
oathtool from
https://github.com/malept/oath-toolkit/
squid-proxy
https://www.squid-cache.org/

Usage:
In your squid.conf set "auth_param basic program" directive to the path for the script with r+x access for the squid user.
Set the `totp.key` file contents to your TOTP source bytes (same thing as you're feeding to `totp-cli instant` or whatever authenticator)
Set PREVPERIODSALLOWED to however may 30-second periods ago you want the script to accept

Sample part of my squid.confg:
```
auth_param basic program /usr/local/libexec/basic_totp_auth.sh
auth_param basic children 10
auth_param basic realm Ihre papiere, bitte!
auth_param basic credentialsttl 2 hours

acl AuthenticatedUsers proxy_auth REQUIRED
http_access allow AuthenticatedUsers
```
