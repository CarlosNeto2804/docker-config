# Docker Puppeteer Dev

## Getting Started
Make sure you have Docker and docker-compose installed and configured so your current user can use both.

Build and run the container:
```
$ make rebuild
```

Wait for the following lines
```
Creating dockerpuppeteerdev_puppeteer_1 ... done
Attaching to dockerpuppeteerdev_puppeteer_1
```

In another terminal session, enter the container:
```
$ make enter
```

Install puppeteer:
```
$ yarn install
```

Now you can run your code within the container:
```
$ node index.js
```
