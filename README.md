![Screenshot](https://s3.amazonaws.com/feebie/feebie_852.png)

# Installation

Install dependencies

```shell
$ npm install
```

Restore db backup for testing

```shell
$ cd dump/feebie
$ mongorestore --drop -v --db feebie .
```

Run dev/build watch server

```shell
$ gulp
```

Start server

```shell
# node public/server
``` 

* The app runs at [localhost:80](http://localhost:80/)
* The API runs at [localhost:81](http://localhost:81/)