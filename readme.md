## Install

Download and copy to `/usr/local/bin` Chrome Driver

`http://chromedriver.storage.googleapis.com/index.html`

Download and copy Selenium Server to `~/projects/selenium/`

`http://www.seleniumhq.org/download/`

Download and install Sahi `java -jar install_sahi_pro_v601_20141117.jar`

`http://sahipro.com/downloads-archive/`

Copy `license.data` to `~/sahi_pro/config`

Install http-server https://github.com/nodeapps/http-server

`npm install http-server -g`

Add `_section` and `circle` to `sahi/config/normal_functions.txt`

Add to `sahi_pro/htdocs/spr/concat.js`

`this.addAD({tag: "CIRCLE", type: null, event:"click", name: "_circle", attributes: ["sahiText", "title|alt", "id", "index", "href", "className", "cx"], action: "_click", value: "sahiText"});`

`this.addAD({tag: "SECTION", type: null, event:"click", name: "_section", attributes: ["sahiText", "title|alt", "id", "index", "href", "className"], action: "_click", value: "sahiText"});`
