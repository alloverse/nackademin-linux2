# Nackademin Linux2 för devops21

This project contains markdown and image sources for all the slides
for nevyn bengtsson's presentations on Linux 2 for devops21 at Nackademin.

The slides are generated from markdown using [`marp`](https://marp.app/).

## Building PDFs from changes in markdowns

* Install nvm: `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash`
* If you use bash, you're fine. If you use fish, [follow this guide](https://eshlox.net/2019/01/27/how-to-use-nvm-with-fish-shell).
* Install the correct version of node: `nvm install` (it'll pick up .nvmrc)
* `make all` to render all of it. npm will install marp for you.

## Resources

* https://pdf.nimbletext.com
* https://www.erase.bg/upload
