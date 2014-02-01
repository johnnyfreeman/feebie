![Screenshot](https://s3.amazonaws.com/feebie/feebie_852.png)

# Installation

Install dependencies

```shell
npm install
```

Restore db backup for testing

```shell
cd dump/feebie
mongorestore --drop -v --db feebie .
```

Run dev/build watch server

```shell
gulp
```