# Docker with Node and Chrome

This is a Docker configuration for creating Docker containers with Node and Chrome for testing on local environments and CI tools (Gitlab-ci, Jenkins, Tavis-ci, Githab actions...).

The `Dockerfile` uses an Alpine based image with specific version of Node and install Chrome and its minimal dependencies, so it can be used for web apps' testing. With frameworks like Karma.

## Versions

Right now there are 3 Docker images already built and available at [juanje/node-chrome](https://hub.docker.com/r/juanje/node-chrome):

* **10.18-alpine** (with Node version 10.18)
* **12.13.0-alpine** (with Node version 12.13.0)
* **13.2.0-alpine** (with Node version 13.2.0)


 You can download the last version (with Node version 13.2.0) by doing:
```
$ docker pull juanje/node-chrome
```

But you can download one specific version, for example:
```
$ docker pull juanje/node-chrome:10.18-alpine
```

## Usage

The containers will run the command `node` as user **node** by default. It's always good idea to run yours containers as non-root user.

You can use it in a CI tool (the main use for this image) or for local testing. If you want to test your local code against a specific version of Node, this can help:
```
$ cd myproject
$ docker run -it --rm -v $PWD:/app juanje/node-chrome:12.13.0-alpine sh
/app $ npm install
/app $ npm test
```


## Testing with Karma

In order to use **Chrome Headless** for testing your **Node** (Node, Angular, React, etc) app with **Karma** you can add this lines to your configuration, so you can  run the tests from inside the container:

```js
    browsers: ['ChromeHeadlessNoSandbox'],
    customLaunchers: {
        ChromeHeadlessNoSandbox: {
            base: 'ChromeHeadless',
            flags: [
                "--no-sandbox",
                 // required to run without privileges in Docker
                "--disable-web-security",
                "--disable-gpu",
                "--remote-debugging-port=9222"
            ]
        }
    },
```

## Build

You can create your own images with this [Dockerfile](Dockefile). To build an image with specific version you need to pass that version as a `--build-arg`. For example:
```
docker build . -t yourname/node-chrome:10.18-alpine --build-arg NODE_VERSION=10.18
```


## License

|                |                                           |
| -------------- | ----------------------------------------- |
| **Author:**    | Juanje Ojeda (<juanje.ojeda@gmail.com>)   |
| **Copyright:** | Copyright (c) 2020 Juanje Ojeda           |
| **License:**   | Apache License, Version 2.0               |

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
