<a href="https://www.durgasoftonline.com/courses/MongoDB-New-Batch-Videos-18th-DEC-8-AM-by-Durga-Sir-5fe2bdfc0cf2817f67426bcc"><img src="https://i.ibb.co/kSkJQKk/image.png" alt="mongodb-batch"></a>

> Online Compiler: https://www.mycompiler.io/new/mongodb

MongoDB comes from Humongous, it means Extremely large. It can handle large amount of data.

MongoDB database vendor is MongoDB. We can use MongoDB anywhere (mobile, desktop, cloud). MongoDB is JavaScript based and behind the scene it uses Mozilla Spider Monkey engine.

> [MongoDB Cheat Sheet](./MongoDB-Cheatsheet.md)

## Stack

The technologies which can be used to develop web applications are called stack. 2 stacks are very popular with MongoDB.

* MERN - MongoDB, Expressjs, Reactjs, Nodejs
* MEAN - MongoDB, Expressjs, Angularjs, Nodejs

> MongoDB is document based aka NoSQL database.

This database contains multiple collections (table in SQL) and each collection contains multiple documents (rows in SQL). Data is stored in separate documents and each document is independent of others.

> MongoDB represents data in JSON format and internally stores data in BSON (binary JSON)

```js
// document1
{
  "name": "John Doe",
  "age": 20,
  "address": "Khulna"
}
// document2
{
  "name": "John Snow",
  "address": "Moscow"
}
```

> Performance and flexibility is the biggest assets of MongoDB

## Key Characteristics 

* Installation and setup is very easy.
* All information related to a document will be stored in a single place. To retrieve data, it is not required to perform join operations and hence retrieval is very fast.
* Documents are independent of each other and no fixed schema. Hence we can store unstructured data like videos, audio files etc.
* We can perform operations like update existing document, delete document and inserting new documents very easily.
* Retrieval data is in the form of JSON which can be understandable by any programming language.
* We can store very huge amount of data and hence scalability is more.

## Theory

MongoDB physical database contains several logical databases. Each database contains several collections (table) and each collection contains several documents. Documents are like record/row in SQL database.

Once we install MongoDB, we get `MongoDB Shell (client)` and `MongoDB Server`. These are JavaScript based applications. `MongoDB server` is responsible to store data in database. By using `MongoDB Shell` we can perform all CRUD operations.

MongoDB Server can be either local or remote.

* to launch server - `$ mongod` command
* to launch shell - `$ mongo` command
* Robo t3, Compass are GUI apps for MongoDB shell

From application (java, python) if we want to communicate with MongoDB database, some special software is required, which is called MongoDB drivers .

* [mongodb/docs/drivers](https://www.mongodb.com/docs/drivers/)
* [PyMongo Documentation](https://pymongo.readthedocs.io/en/stable/)

![mongdb-drivers](https://i.ibb.co/Syq2wws/image.png)

* To check MongoDB server version - `$ mongod -version`
* To check MongoDB shell version - `$ mongo -version`

## Installation

* [MongoDB Community Edition](https://www.mongodb.com/try/download/community)

> you must have to add `mongodb bin` path in the environment variable.

To store data you must have to create `data/db` directory inside a Drive and run the following `mongod` command to start the MongoDB shell from the same drive.

you can also specify other location via `mongod --dbpath "location"`

`mongod` is the command that starts the server and `mongo` is command line tool to perform operations.

```js
$ mongo // shell started
$ db.version()
$ show dbs // list of default databases
$ use abcDB // switch to abcDB database
$ show collections // display all collections from a particular database
```

* Default Databases `show dbs`
* admin
    * It is used to store authentication & authorization information.
    * Used by administrator to perform users CRUD Operations and assign roles.
* config
    * To store config information of mongoDB server
* local
    * It is used by admin while performing replication process.

## Data Formats

Client write JavaScript objects/JSON but MongoDB server stores them as BSON format.

JS objects/JSON provides only handful of types (string, number, array, object, boolean, null) rest of the types are provided by BSON. also since BSON saves data as binary format, it requires less space compare to JSON.

When client sends a request to mongoDB server in JS objects/JSON format (insertion), internally it converts into BSON format then save it to the memory... When client retrieve (get) something from mongoDB, mongoDB sends eJSON (extended JSON) data.

* Insert into documents ➝ JS objects/JSON to BSON
* Retrieval from documents ➝ BSON to eJSON

```js
show dbs // shows all available databases
use dynamoDB // switched to db dynamoDB
show dbs // we won't see dynamoDB until we insert documents/create a new collection
db.createCollection("products") // { ok: 1 }
show dbs // now we can see dynamoDB
db.products.drop() // drop a collection
db.dropDatabase() // current database will be dropped
db.getName() // name of the database you're currently in
```

> Any word prefix with `$` means it is reserved word for mongoDB.

## ObjectId

For every document MongoDB server is associated with a unique ID, which is ObjectId. It behaves like primary key in relational databases. ObjectId is assigned to `_id` field. It is BSON type.

```js
{
    _id: ObjectId("random string")
}
```

* ObjectId is 12 bytes:
    * first 4 bytes represents the timestamp when the documents was inserted
    * next 3 bytes represents machine id (host name)
    * the next 2 bytes represents process id
    * last 3 bytes represents random incremental value

### Generate Timestamp from ObjectId

* `db.collection.findOne()._id.getTimestamp()` - return the document's creattion time

By using `_id` field, we can provide its value. MongoDB server will generate its value (immutable ObjectId, which is unique per collection), if we do not provide any `_id` value. Duplicate `_id` is not possible.

## CRUD Operation

### Insertion

There are 3 ways to insert documents into the collections

* `db.collection.insert()` -- deprecated
* `db.collection.insertOne({JS object})`
* `db.collection.insertMany([{}, {}])`

```js
show dbs
use durgaDB
db.createCollection("Employees")

db.Employees.insertMany([
    {
        "eno": 100,
        "ename": "John Doe",
        "esal": 10000,
        "eaddress": "Hyderbad"
    },
    {
        "eno": 200,
        "ename": "John Snow",
        "esal": 20000,
        "eaddress": {
            "country": "India",
            "city": "Pune"
        }
    },
    {
        "eno": 300,
        "ename": "Junior John Snow",
        "esal": 30000,
        "eaddress": "Mumbai"
    }
])
```

### Retrieval

There are 2 ways to read data from the collections

* `db.collection.find({optional: condition})`
    * default is all documents, if condition is absence.
* `db.collection.findOne({optional: condition})`
    * default is first document, if condition is absence.

```js
db.Employees.find()
db.Employees.find().pretty() // readable format

db.Employees.find().forEach((doc) => {
    printjson(doc)
})

let employee = db.Employees.findOne() // return 1st document
printjson(employee)
```

### Update

There are 3 ways to update documents

* `db.collection.updateOne({condition: value}, {$set: {key: value}})`
* `db.collection.updateMany()`
* `db.collection.replaceOne()`

```js
db.Employees.updateOne(
    {"ename": "John Doe"}, 
    {$set: {"eaddress": "New Delhi"}}
)

db.Employees.find()
```

if `eaddress` doesn't exist in the document then it will create new `eaddress` property else replace old value with new value.

### Deletion

There are 2 ways to delete data from the collections

* `db.collection.deleteOne()`
* `db.collection.deleteMany()`

```js
db.abcdDB.insertOne({
    "hello": "World",
    "city": "Moscow"
})

db.abcdDB.deleteOne({
    "hello": "World"
})
```

## Capped Collection

* Capped collections are fixed-size collections that insert and retrieve documents based on insertion order.
* If the max number documents are reached/memory is exceeded then old data will be deleted based on timestamp.
* when capped is true, you've to add either size (bytes) or max value.

```js
use ecommerceDB
db.createCollection("Orders", {"capped": true, "size": 373658, "max": 1})

db.Orders.insertOne({
    "product": "Mango",
    "price": "$20"
})

// add multiple orders
let orders = [
    {
        "product": "JackFruit",
        "price": "$15",
        "quantity": 3
    },
    {
        "product": "Soap",
        "price": "$5",
        "quantity": 10,
        "brand": "Square"
    }
]

db.Orders.insertMany(orders)
db.Orders.find().pretty() // Soap
```

## Insert documents from JavaScript file

```js
use studentDB

db.createCollection("students")
load('file-path.js')

db.students.find().count()
```

## Insert documents from JSON file

* The data should be in the array form - `[{}, {}]`
* Data must be valid JSON.

#### Steps to follow

* `$ mongod` ➝ start mongoDB server
* `$ mongo` ➝ start mongoDB shell
* `$ mongoimport` ➝ to import json file | by default it is not available, install manually
    * https://www.mongodb.com/try/download/database-tools
    * https://www.mongodb.com/docs/database-tools/
    * copy `mongoimport.exe` file & paste it `mongoDB/server/version/bin/`
    * open a new command prompt and go to where json file is available

```shell
# mongoimport will create database and collections if they aren't available.
# if collection is already available, new documents will be appened
$ mongoimport --db dbName --collection collectionName --file ./file-path.json --jsonArray
```

## Insert documents from CSV file

```js
$ mongoimport --db dbName --collection collectionName --type csv --headline --drop ./file-path.csv
```

## Nested Documents

Sometimes we can take a document inside another documents, these type of dcouments are called nested documents or embedded documents. MongoDB supports 100 level of nesting.

```js
// books.json
[
    {
        "title": "Python in Action",
        "isbn": 1234,
        "downloadable": true,
        "no_of_reviews": 10,
        "authors": {
            "name": "Daniel Cohen",
            "callname": "Dan"
        }
    },
    {
        "title": "MongoDB in Action, 3rd Edition",
        "isbn": 4321,
        "downloadable": false,
        "no_of_reviews": 5,
        "authors": {
            "name": "Shiva Ramachandran",
            "callname": "Shiva"
        }
    },
    {
        "title": "Django in Action",
        "isbn": 1243,
        "downloadable": true,
        "no_of_reviews": 0,
        "authors": {
            "name": "Christopher",
            "callname": "Chris",
            "profile": {
                "experience": 8,
                "courses": 3,
                "books": 12
            }
        }
    },
    {
        "title": "DevOps in Action",
        "isbn": 124356,
        "downloadable": false,
        "no_of_reviews": 20,
        "tags": ["jenkins", "git", "ansible", "CI/CD", "docker"],
        "languages": ["English", "Hindi", "Telegu"],
        "authors": {
            "name": "Martin Kohenova",
            "callname": "Mat",
            "profile": {
                "experience": 8,
                "courses": 5,
                "books": 2
            }
        }
    }
]

$ mongoimport --db storedb --collection books --file ./books.json --jsonArray
```

## Ordered Insertion in Bulk Insert

We can perform bulk inserts by using `insertMany()` method. An array of objects will be inserted into the collection.

```js
use carDB
db.createCollection("Cars")

db.Cars.insertMany([
    {
        "_id": 100,
        "M": "Marti"
    },
    {
        "_id": 200,
        "A": "Audi"
    },
    {
        "_id": 300,
        "B": "Benz"
    }
])
```

By default, while performing bulk inserts if any of the object raise an error, rest of the objects won't be inserted. But the objects which are already inserted won't be roll back. [previous objects - inserted] ➝ insertion fail ➝ [next objects - won't be inserted]

```js
db.Cars.insertMany([
    {
        "_id": 400,
        "x": "X"
    },
    {
        "_id": 400,
        "y": "Y"
    },
    {
        "_id": 500,
        "z": "Z"
    }
])

db.Cars.find() // insertion _ids are 400
```

We can customize this default behavior. If one object insertion fails, rest of the objects will be inserted. For this we've to set ordered property false.

```js
db.collection.insertMany( [{}, {}, {}], {ordered: false} )

db.Cars.insertMany([
    {
        "_id": 800,
        "R": "Ritz"
    },
    {
        "_id": 800,
        "I": "Innova"
    },
    {
        "_id": 900,
        "G": "Gitz"
    }
], { ordered: false })

db.Cars.find() // insertion _ids are 800, 900
```

## Atomicity

* How to rollback already inserted objects in case of any error in bulk inserts?
    * By using, transactions

Assume we have to insert an object where 100 properties are available, after inserting 50 properties database server crashes then what will happen?

Whatever properties were inserted will be roll backed.

MongoDB server stores either complete object or nothing. It won't store part of the object. CRUD operatios are atomic at object level.

```js
db.collection.insertMany([ {}, {}, {} ], { ordered: false }, { writeConcern: 0 })
```

But while inserting multiple objects (bulk insertion), after inserting some objects if database server crashes, then already inserted documents won't be roll backed (default). Atomicity is not applicable by default.

If we want atomicity for bulk inserts then we should go for transcation concepts.

> Transcation means either all operations or none

## writeConcern

Whenever, we are performing insert operation, by default shell waits until getting acknowledgement. Server provides `{acknowledgement: true}` after insert operation. This may reduce the performance at client side.

We can customize this behavior by using `writeConcern` property.

```js
db.collection.insertOne({}, { writeConcern: {w: 0} })
// w: 1 -> default
// w: 0 -> client won't get acknowledgement
```

In production, for every database we have to maintain cloned/replica database because

* to handle single point of failure
* for load balancing purposes

A single object is required to insert in multiple database instances like primary database, replica-1, replica-2. After inserting from how many instances, you are expecting acknowledgement, we can set this by using `writeConcern` property.

```js
db.collection.insertOne({}, { writeConcern: {w: 1} })
// w: 1 -> acknowledgement only from primary database after inserting object
// w: 2 -> acknowledgement from primary and replica-1 databases after inserting object
// w: 3 -> acknowledgement from primary and replica-1, replica-2 databases after inserting object

db.collection.insertMany([{}, {}, {}], { writeConcern: {w: 3} })
// generate an error: can't use "w > 1" when a host is not replicated
```

> writeConcern is applicable for any write operation like insert, update, and delete.

## Reading data

We can fetch documents from the collection by using following methods

* `db.collection.find({ key: value })`
    * NOTE: `find()` return a cursor object. By using this cursor, we get batch (single batch is 20 documents) of documents (pagination). To customize this default behavior set `DBQuery.shellBatchSize=5`.
    * Basic Cursor Methods:
        * count
        * next [1 document at a time]
            ```js
            // BAD Practice
            db.collection.find().next() // return a document
            db.collection.find().next() // return previous document again
            // every time cursor object gets reset, that's why same document

            // GOOD Practice
            let cursor = db.collection.find()
            cursor.next() // return BSON object
            cursor.next()
            ```
        * hasNext
            ```js
            let myCursor = db.collection.find()
            while (myCursor.hasNext()) {
                printjson(myCursor.next())
            }

            myCursor.forEach((doc) => {
                printjson(doc)
            })

            // shortcut
            myCursor.forEach(print)
            ```
        * toArray
    * Cursor Methods for Pagination:
        * limit
        * skip
        * batchSize
    * if we don't provide any query inside `find()`, all documents will be returned.
    * when we provide query inside `find()`, all matched documents will be returned.
* `db.collection.findOne({ key: value })`
    * if we don't provide any query inside `findOne()`, first document will be returned.
    * when we provide query inside `findOne()`, first matched document will be returned.

> these `find()` methods are similar to `select` query in sql.

```js
// books.json
[
    {
        "title": "Linux in simple way",
        "isbn": 6677,
        "downloadable": false,
        "no_of_reviews": 1,
        "tags": ["os", "freeware", "shell programming"],
        "languages": ["english", "hindi", "telegu"],
        "author": {
            "name": "Shiva Ramachandran",
            "callname": "Shiva",
            "profile": {
                "years_of_experience": 8,
                "courses": 3,
                "books": 2
            }
        }
    },
    {
        "title": "Java in simple way",
        "isbn": 1122,
        "downloadable": true,
        "no_of_reviews": 2,
        "tags": ["freeware", "language", "programming"],
        "languages": ["english", "hindi", "telegu"],
        "author": {
            "name": "Karthik Kumar",
            "callname": "Karthik",
            "profile": {
                "years_of_experience": 1,
                "courses": 2,
                "books": 3
            }
        }
    },
    {
        "title": "Python in simple way",
        "isbn": 1234,
        "downloadable": false,
        "no_of_reviews": 5,
        "tags": ["freeware", "language", "programming"],
        "languages": ["english", "hindi", "telegu"],
        "author": {
            "name": "Samual Cohen",
            "callname": "Sam",
            "profile": {
                "years_of_experience": 8,
                "courses": 7,
                "books": 6
            }
        }
    },
    {
        "title": "DevOps in simple way",
        "isbn": 6679,
        "downloadable": false,
        "no_of_reviews": 3,
        "tags": ["jenkins", "git", "docker", "cicd"],
        "languages": ["english", "hindi", "telegu"],
        "author": {
            "name": "Micheal Jordan",
            "callname": "Micheal",
            "profile": {
                "years_of_experience": 4,
                "courses": 4,
                "books": 4
            }
        }
    },
    {
        "title": "MongoDB in simple way",
        "isbn": 6672,
        "downloadable": true,
        "no_of_reviews": 4,
        "tags": ["database", "cloud", "nosql"],
        "languages": ["english", "hindi", "telegu"],
        "author": {
            "name": "John Smilga",
            "callname": "John",
            "profile": {
                "years_of_experience": 6,
                "courses": 7,
                "books": 8
            }
        }
    },
    {
        "title": "MySQL in simple way",
        "isbn": 6689,
        "downloadable": true,
        "no_of_reviews": 3,
        "tags": ["database", "sql", "relational"],
        "languages": ["english", "hindi", "telegu"],
        "author": {
            "name": "Ben Forta",
            "callname": "Ben",
            "profile": {
                "years_of_experience": 2,
                "courses": 3,
                "books": 2
            }
        }
    },
    {
        "title": "Shell Scripting in simple way",
        "isbn": 9988,
        "downloadable": true,
        "no_of_reviews": 1,
        "tags": ["programming"],
        "languages": ["english", "telegu"],
        "author": {
            "name": "Neo Hao",
            "callname": "Neo",
            "profile": {
                "years_of_experience": 8,
                "courses": 3,
                "books": 2
            }
        }
    },
    {
        "name": "xyz"
    }
]

// database - storeDB
// collection - books
// file - books.json

$ mongoimport --db storeDB --collection books --file ./books.json --jsonArray
$ db.books.find().count() // 7
```

* List out all documents present in books collection?
    * `db.books.find().pretty()`
* Find total number of documents present in books collection?
    * `db.books.find().count()`
* Find first document present in books collection?
    * `db.books.findOne()`
    * `count()/pretty()` is not a function for `findOne()`
* Find all documents where `downloadable` is false?
    * `db.books.find({downloadable: false}).pretty()`
* Find all documents where `no_of_reviews` is 3?
    * `db.books.find({no_of_reviews: 3}).pretty()`

### Querying nested documents

If the value of a field again a document then nested property values we can access via `.` operator. In this case, key must be enclosed with quotes.

```js
// select all documents where author's callname is Neo?
db.books.find({ "author.callname": "Neo" })

// select all documents where author's profile contains 2 courses?
db.books.find({ "author.profile.courses": 2 })
```

### Querying Arrays

* List out all documents where `tags` array contains `programming` element?
    * `db.books.find({ tags: "programming" }).pretty()`
        * querying array element
    * `db.books.find({ tags: ["programming"] })`
        * querying array itself
* List out all documents where `languages` contains `telegu` element?
    * `db.books.find({ languages: "telegu" }).pretty()`
* List out all documents where `tags` array is `["freeware", "language", "programming"]`
    * `db.books.find({tags: ["freeware", "language", "programming"]})`
    * Array order & case is matter

## Query Operators

Every operator prefix with `$` symbol.

### Comparison Operators

* $lt
* $lte
* $gt
* $gte
* $ne
* $eq
* $in
* $nin

> Syntax: `db.collection.find({ key: {operator: value} })`

#### $eq

The `$eq` operator matches documents where the value of the field is equal to specified value.

> Syntax: `db.collection.find({ key: {$eq: value} })`  
Shortcut Syntax: `db.collection.find({ key: value })`

```js
// Select all documents where `no_of_reviews` is 3?
db.books.find({ no_of_reviews: {$eq: 3} })

// Select all documents where author's profile contains 2 courses?
db.books.find( {"author.profile.courses": {$eq: 2} }).pretty()

// Select all documents where `tags` array contains `database` element?
db.books.find({ tags: {$eq: "database"} }).pretty()

// Select all documents where `tags` array is exactly as `["language", "freeware", "programming"]`
db.books.find({ tags: {$eq: [language", "freeware", "programming"]} })`
```

#### $ne

`$ne` means not equal. We can use `$ne` operator to select all documents where the value of the field is not equal to specified value.

> Syntax: `db.collection.find({ key: {$ne: value} })`

```js
// Select all documents where `no_of_reviews` not 3?
db.books.find({ no_of_reviews: {$ne: 3} })
```

If the specified `key` is not present in the document, that document will also be included. Only happens when we perform `not equal/ not in` action.

#### $gt

`$gt` means greater than operator. We can use `$gt` operator to select all documents where the value of key is `>` specified value.

> Syntax: `db.collection.find({ key: {$gt: value} })`

```js
// Select all documents where `no_of_reviews` are greater than 3?
db.books.find({ no_of_reviews: {$gt: 3} })`
```

#### $gte

`$gte` means greater than or equal to operator. We can use `$gte` operator to select all documents where the value of key is `>=` specified value.

> Syntax: `db.collection.find({ key: {$gte: value} })`

```js
// Select all documents where `no_of_reviews` are greater than or equal to 3?
db.books.find({ no_of_reviews: {$gte: 3} })
```

#### $lt

`$lt` means less than operator. We can use `$lt` operator to select all documents where the value of key is `<` specified value.

> Syntax: `db.collection.find({ key: {$lt: value} })`

```js
// Select all documents where `no_of_reviews` are less than 3?
db.books.find({ no_of_reviews: {$lt: 3} })`
```

#### $lte

`$lte` means less than or equal to operator. We can use `$lte` operator to select all documents where the value of key is `<=` specified value.
 
> Syntax: `db.collection.find({ key: {$lte: value} })`

```js
// Select all documents where `no_of_reviews` are less than or equal to 3?
db.books.find({ no_of_reviews: {$lte: 3} })`
```

#### $in

We can use `$in` operator to select all documents where the value of a field  equals any value in specified array.

> Syntax: `db.collection.find({ key: {$in: [value1, value2, value3...]} })`

```js
// Select all documents where `no_of_reviews` in `[1, 4, 5]`?
db.books.find({ no_of_reviews: {$in: [1, 4, 5]} })

// Select all documents where `tags` array contains `database` or `programming`
db.books.find( {tags: {$in: ["database", "programming"] }} )
```

#### $nin

We can use `$nin` operator to select all documents where the value of a field not present in specified array.

* `$nin` operator will select:
    * the field value doesn't present in specified array.
    * the field doesn't exist.

> Syntax: `db.collection.find({ key: {$nin: [value1, value2, value3...]} })`

```js
// Select all documents where `no_of_reviews` not in `[1, 4, 5]`?
db.books.find({ no_of_reviews: {$nin: [1, 4, 5]} })

// Look at the query `db.books.find({exams: 5}).count()`
// all documents will return, cause `exams` is not a valid field in the books collection
```

### Logical Operators

* $or
* $and
* $not
* $nor

#### $or Operator

`$or` performs logical or operator on an array of 2 or more conditions and selects the documents that satisfy at least one condition.

> Syntax: `db.collection.find({ $or: [condition1, condition2, conditionN] })`

```js
// Select all documents where tags array contains `programming` or `no_of_reviews > 3`?
db.books.find({ $or: [{ no_of_reviews: {$gt: 3} }, { tags: {$in: "programming"} }] })

// Select all documents where either `no_of_reviews < 3` or `{downloadable: true}` or `author` profile contains at least `2` books?
db.books.find({ 
    $or: [ 
            {no_of_reviews: {$lt: 3}}, 
            {downloadable: {$eq: true}}, 
            {"author.profile.books": {$gte: 2}} 
    ] 
})
```

#### $nor Operator

It is inverse of `$or` Operator. $nor` performs a logical NOR operation on an array of one or more conditions and selects the documents that fails all query condition.

* $or: At least one condition is satisfied
* $nor: Neither condition is satisfied aka all condition fails

> Syntax: `db.collection.find({ $or: [condition1, condition2, conditionN] })`

Look at the below query

```js
db.books.find({ 
    $nor: [
        {no_of_reviews: {$gt: 3}}, 
        {downloadable: true}
    ]
})
```

It selects the documents where below conditions (both in a single document) are matched.

* The `no_of_reviews` is less than or equal to 3
* `downloadable` is false
* It also picks up such documents that don't contain neither `no_of_reviews` nor `downloadable` fields.

#### $and Operator

`$and` performs logical AND Operation on an array of one or more expressions and selects the documents that satisfy all expressions in the array.

> Syntax: `db.collection.find({$and: [condition1, condition2, conditionN]})`   
Shortcut Syntax: `db.collection.find({ field1: value1, field2: value2 })`

```js
// Select all documents where `no_of_reviews <= 3` and `{downloadable: true}`
db.books.find( $and: [{no_of_reviews: {$gte: 3}}, {downloadable: true}] )

// students.json
[
    {
        "name": "A",
        "marks": 10
    },
    {
        "name": "B",
        "marks": 20
    },
    {
        "name": "C",
        "marks": 30
    },
    {
        "name": "D",
        "marks": 40
    },
    {
        "name": "E",
        "marks": 50
    },
    {
        "name": "F",
        "marks": 60
    },
    {
        "name": "G",
        "marks": 70
    },
    {
        "name": "H",
        "marks": 80
    },
    {
        "name": "I",
        "marks": 90
    },
    {
        "name": "J",
        "marks": 100
    }
]

$ mongoimport --db storeDB --collection students --file ./students.json --jsonArray
$ db.students.find().count() // 10

// Select all documents where `marks` are less than 85 and greater than 45?
db.students.find( $and: [{marks: {$gt: 45}}, {marks: {$lt: 85}}] )
db.students.find( {marks: {$gt: 45}, marks: {$lt: 85}} )
// if both conditions are on same field `{ marks: < 50, marks: >= 35 }`, 
// then shortcut syntax won't work as expected. Because duplicate keys are not allowed in JS object.
```

#### $not Operator

`$not` operator performs logical NOT operation on the specified operator expression and selects the documents that do not match operator expression. This includes also the documents that don't contain the field.

> Syntax: `db.collection.find({ key: {$not: {$gt: value}} })`

Look at the query `db.students.find( {marks: {$not: {$gt: 55}}})`

* Above query will return the following documents
    * where `marks >= 55`.
    * `marks` field doesn't exist in the document.

### Element Query Operators

* $exists
* $type

#### $exists

> Syntax: `db.collection.find({ key: {$exists: <boolean>} })`

* If `boolean=true` then select all documents that contain specified field even value of the field is `null`.
* If `boolean=false` then select all documents that don't contain specified field.

```js
// Select all fields which contains `no_of_reviews` field?  
db.collection.find({ no_of_reviews: {$exists: true} })

// Select all fields which don't contains `no_of_reviews` field?    
db.collection.find({ no_of_reviews: {$exists: false} })

// Select all documents which contains `gf` field also `marks` are higher than 70?  
db.collection.find({ gf: {$exists: true}, marks: {$gt: 70} })
```

#### $type

`$type` operator selects the documents where value of a field is of a particular type. We've to specify the type as BSON type.

> Syntax: `db.collection.find({key: {$type: <bson type>}})`    
Syntax: `db.collection.find({key: {$type: [<bson type1>, <bosn type2]}})`

we can specify either number or alias name for BSON type.

![available-types](https://i.ibb.co/0Q4ThZS/image.png)

`$type` also supports "number" alias which will match following types - int, long, double, decimal.

> double is 64 bits & decimal is 128 bits floating point value.

```js
use phoneDB
db.createCollection("phonebook")

db.phonebook.insertMany([
    {
        "name": "Sunny Leone", 
        "phone": "895255"
    },
    {
        "name": "Violet Gems", 
        "phone": 789555888
    },
    {
        "name": "Sophia Burns", 
        "phone": NumberLong("889544596")
    },
    {
        "name": "Kristy Black", 
        "phone": NumberInt(888)
    },
    {
        "name": "Leya Falcon", 
        "phone": [NumberLong(789), "89656", 847684]
    },
])

// select all documents where phone value is string or int
db.phonebook.find({
    phone: { $type: ["int", 'string'] }
})

db.phonebook.find({
    phone: { $type: 16 }
})
```

### Evaluation Query Operators

* $expr
* $regex
* $mod
* $jsonSchema
* $text
* $where (deprecated)

```js
use expensesdb
db.createCollection("homeBudget")

db.homeBudget.insertMany([
    {category: "home food", budget: 1000, spent:1500},
    {category: "outside food", budget: 1000, spent: 2000},
    {category: "rent", budget: 1500, spent:1500},
    {category: "education", budget: 2000, spent:1000},
    {category: "clothes", budget:750, spent:1500},
    {category: "entertinement", budget: 1000, spent:2500},
    {category: "Travel", budget: 5000, spent:4000},
    {category: "Print", budget: 1000, spent:1200}
])

// select all documents where budget value is 1000
db.homeBudget.find({
   budget: 1000 
})

// select all documents where category is rent 
db.homeBudget.find({
   category: 'rent' 
})
```

#### $expr operator

Within the same document when You've to compare 2 fields, use `$expr` operator. `$expr` operator is very commounly use within aggregate function.

> Syntax: `db.collection.find({ $expr: {<expression>} })`

```js
// select all documents where spent amount exceeds budget amount?
db.homeBudget.find({
   $expr: {$gt: ["$spent", "$budget"]}
})

// select all documents where spent amount less than or equal to budget amount?
db.homeBudget.find({
   $expr: {$lte: ["$spent", "$budget"]}
})
```

#### $regex

We can use `$regex` operator to select documents where values match a specified regex pattern. By default case is considered. If you want to ignore case then add `$optioans: "i"`

> Syntax: `db.collection.find({ key: {$regex: /pattern/, $options: "i"} })`  
Syntax: `db.collection.find({ key: {$regex: /pattern/i} })`  
Syntax: `db.collection.find({ key: {$regex: "pattern", $options: "i"} })`  
Syntax: `db.collection.find({ key: /pattern/i })`  

```js
// select all documents where category contains "food" word?
db.homeBudget.find({category: /food/})
db.homeBudget.find({category: {$regex: "food"}})
db.homeBudget.find({category: {$regex: /food/}})

// select all documents where category value starts with "e"?
db.homeBudget.find({ category: /^e/ })
db.homeBudget.find({ category: {$regex: "^e"} })
db.homeBudget.find({ category: {$regex: /^e/} })

// select all documents where category value starts with either "e" or "c" ?
db.homeBudget.find({ category: /^e|c/ })
db.homeBudget.find({ category: /^[ec]/ })

// select all documents where category value ends with either "t" or "n" ?
db.homeBudget.find({ category: /[tn]$/ })

// select all documents where category value starts with either "T/t" or "P" ?
db.homeBudget.find({ category: /^[tTP]/i })
```

#### $mod

We can use `$mod` operator to select documents where the value of the field divided by a divisor has a specified reminder.

> Syntax: `db.collection.find({ key: {$mod: [divisor, reminder]} })`

```js
use shoppingdb
db.createCollection("shop")

db.shop.insertOne ({_id: 1, item: "soaps", quantity: 13})
db.shop.insertOne ({_id: 2, item: "books", quantity: 10})
db.shop.insertOne({_id: 3, item: "pens", quantity: 15})
db.shop.insertOne ({_id: 4, item: "pencils", quantity: 17})

// select all documents where quantity value is divisible by 5
db.shop.find({
    quantity: {
        $mod: [5, 0] // [divisor=5, reminder=0]
    }
})

// select all documents where quantity value is divisible by 4 and has a reminder 1
db.shop.find({
    quantity: {
        $mod: [4, 1]
    }
})
```

#### $jsonSchema

We can select documents based on specified JSON schema by using this operator.

> Syntax: 

#### $text

related to index concepts, coming soon.

> Syntax: 

### Array Query Operators

* $all
* $elemMatch
* $size

```js
use coursedb
db.createCollection("courses")

db.courses.insertMany([
    {
        _id:1,
        name:"Java",
        tags:["language", "programming", "easy","ocean"]
    },
    {
        _id:2, 
        name: "Python", 
        tags: ["language", "programming", "easy"]
    },
    {
        _id:3, 
        name: "C", 
        tags: ["language", "performance"]
    },
    {
        _id:4, 
        name: "Oracle", 
        tags: ["database","sql","cloud"]
    },
    {
        _id:5, 
        name: "MongoDB", 
        tags: ["database", "nosql","cloud"]
    },
    {
        _id:6, 
        name: "Devops", 
        tags: ["culture"]
    }
])
```

#### $all

We can use `$all` operator to select documents where array contains all specified elements.

> Syntax: `db.collection.find({ key: {$all: [val1, val2, val3]} })`

```js
// select all documents where tags array contains "database" and "cloud" elements?
db.courses.find({
    tags: {$all: ["database", "cloud"] }
})

// NOTE: Order is not important and also it's not exact match
// Also, we can solve this problem with $and operator
db.courses.find({
    $and: [
        {tags: "database"},
        {tags: "cloud"}
    ]
})

// select all documents where tags array contains "language" and "programming"
db.courses.find([
    tags: {$all: ["language", "programming"]}
]) 
```

#### $elemMatch

We can use `$elemMatch` (any() in python) operator to select documents where at least one element of the array matches the specified query criteria. 

> Syntax: `db.collection.find({ key: {$eleMatch: {<query1>, <query2>...}} })`

```js
db.students.drop()
db.createCollection("students")

db.students.insertOne ({_id: 1, name: "Durga", marks: [82,35,99]})
db.students.insertOne({_id: 2, name: "Ravi", marks: [75,90,95]})

// Select documents where student has at-least one subject marks greater than or equal to 80 but less than 90?
db.students.find({
    marks: { $elemMatch: {$gte: 80, $lt: 90} }
})

// ?
db.courses.find({
    tags: {
        $elemMatch: ["language", "programming"]
        $elemMatch: { tags: "language", tags: "programming"}
    }
})
```

#### $size

We can use `$size` operator to select documents based on specified array size

> Syntax: `db.collection.find({ key: {$size: n} })`

```js
// Select documents that contains only 3 elements in marks array?
db.students.find({
    marks: { $size: 3 }
});
```

## Cursor Methods

### Helper methods

* limit
* skip
* sort

> https://www.codemzy.com/blog/mongodb-skip-limit-order

#### limit

> Syntax: `db.collection.find().limit(n)`

If there are fewer than `n` documents matching your query in the collection, only the number of matching documents will be returned; limit sets an upper limit, not a lower limit.

#### skip

> Syntax: `db.collection.find().skip(n)`

This will skip the first `n` matching documents and return the rest of the matches. If there are fewer than `n` documents in your collection, it will not return any documents.

> When you chain `skip()` and `limit()`, the method chaining order does not affect the results. The server always applies the `skip` before it applies the `limit` - even if you put `limit` first.

#### sort

> Syntax: `db.collection.find().sort({key: 1/-1})`

sort takes an object: a set of key/value pairs where the keys are key names and the values are the sort directions. The sort direction can be 1 (ascending) or −1 (descending). If multiple keys are given, the results will be sorted in that order.

### Projection

Get required document fields instead of all fields called projection

```sql
select * from employees; -- wiihout projection
select full_name, age from employees; -- with projection
```

> Syntax: `db.collection.find(filter, projection)`

If we are providing projection list, compulsory we should provide `filter` object also, atleast empty object `{}`

```js
// both are same
db.collection.find().pretty()
db.collection.find({}, {}).pretty()

// select only `title` and `no_of_reviews` from books collection
db.books.find({}, {
    "title": 1, // 1 mean project this field
    "no_of_reviews": 1, // 0 (default) means exclude/not project this field
    "_id": 0 // by default _id field is included, if u want to exclude it use 0
})

// select all documents where `no_of_reviews` is >= 3 and project the following fields - title, no_of_reviews, isbn
db.books.find({no_of_reviews: {$gte: 3}}, {
    "no_of_reviews": 1,
    "isbn": 1,
    "title": 1,
    "_id": 0
})

// nested projection
db.books.find({no_of_reviews: {$gte: 3}}, {
    "no_of_reviews": 1,
    "isbn": 1,
    "title": 1,
    "author.profile.books": 1
})

// array projection
db.books.find({no_of_reviews: {$gte: 3}}, {
    "no_of_reviews": 1,
    "tags": 1,
    "_id_": 0
})
```

### Array elements Project Operators

* $
* $elemMatch
* $slice

```js
db.books.find({ tags: "programming" }).pretty()
db.books.find({ tags: "programming" }, {title: 1, tags: 1, _id: 0})

// select title and tags from books collection but tags should return only "programming" element not all elements
db.books.find({ tags: "programming" }, {title: 1, "tags.$": 1, _id: 0})
```

#### $

We can use `$` operator to project the first element in an array that matches query condition.

> Syntax: `db.collection.find({query}, {"array.$": 1})`

```js
use studentDB
db.createCollection("student")

db.students.insertOne({_id:1, name: "Durga", year: 1, marks: [70,87,90]})
db.students.insertOne ({_id: 2, name: "Ravi", year: 1, marks: [90,88,92]})
db.students.insertOne ({_id: 3, name: "Shiva", year: 1, marks: [85,100,90]}) 
db.students.insertOne ({_id:4, name: "Durga", year:2, marks: [79,85,80]}) 
db.students.insertOne({_id: 5, name: "Ravi", year:2, marks: [88,88,92]}) 
db.students.insertOne ({_id: 6, name: "Shiva", year:2, marks: [95,98,96]})

// ...
db.students.find({
  year: 1,
  marks: {
    $gt: 85
  }
}, {
  _id: 0,
  "marks.$": 1
})

/* output
{ "name" : "Durga", "marks" : [ 87 ] }
{ "name" : "Ravi", "marks" : [ 90 ] }
{ "name" : "Shiva", "marks" : [ 100 ] }
*/

// WARNING
// If there is no query condition or if query condition won't include array then
// we cannot use $ operator, otherwise we will get an error.

db.students.find({}, {
    _id: 0,
    "marks.$": 1
}) 

db.students.find(
    {
        year: 1
    },
    {
         _id: 0,
        "marks.$": 1
    }
)

// marks must be include in the query
```

#### $elemMatch

We can use `$elemMath` to project first element in the array that matches specified `$elemMatch` condition. It doesn't consider query condition.

> Syntax: `db.collection.find({}, {array: {$elemMatch: {condition}}})`

```js
db.students.find({}, {
    name: 1,
    _id: 0,
    year: 1,
    marks: {
        $elemMatch: {
            $lt: 95
        }
    }
})

/*
{ "name" : "Durga", "marks" : [ 70 ] }
{ "name" : "Ravi", "marks" : [ 90 ] }
{ "name" : "Shiva", "marks" : [ 85 ] }
{ "name" : "Durga", "marks" : [ 79 ] }
{ "name" : "Ravi", "marks" : [ 88 ] }
{ "name" : "Shiva" }
*/
```

#### Difference between `$` and `$elemMatch`?

Both operators project the first matching element from an array based on condition. But `$` operator selects array element based on query condition. But `$elemMatch` selects based on its condition. 

```js
db.students.find({
    year: 1,
    marks: {
        $gte: 85
    }
}, {
    _id: 0,
    name: 1,
    "marks.$": 1
})

/*
{ "name" : "Durga", "marks" : [ 87 ] }
{ "name" : "Ravi", "marks" : [ 90 ] }
{ "name" : "Shiva", "marks" : [ 85 ] }
*/

db.students.find({
    year: 1,
    marks: {
        $gte: 85
    }
}, {
    _id: 0,
    name: 1,
    marks: {
        $gt: 89
    }
})

/*
{ "name" : "Durga", "marks" : [ 90 ] }
{ "name" : "Ravi", "marks" : [ 90 ] }
{ "name" : "Shiva", "marks" : [ 100 ] }
*/
```

#### $slice

By using `$slice` operator we can select required number of elements in the array.

> Syntax: `db.collection.find({}, {array: {$slice: n}})`

```js
// first 2 marks element will be selected
db.students.find({}, {_id: 0, name: 1, marks: {$slice: 2}})

// last 2 marks element will be selected
db.students.find({}, {_id: 0, name: 1, marks: {$slice: -2}})
```

##### To skip number of elements

> Syntax: `db.collection.find({}, {array: {$slice: [n1, n2]}})`

Skip `n1` elements and then select `n2` number of elements.

```js
db.students.find({}, {_id: 0, name: 1, marks: {$slice: [2, 1]}})
```

## Update data

We can perform updation like

* Overwrite existing value of a particular field with new value
* Add a new field for selected document
* Remove an existing field from document
* Rename an existing field

Perform updation

* Update methods
    * updateOne()
    * updateMany()
    * update() -- deprecated
* Update operators
    * $set
    * $unset
    * $rename
    * $inc
    * $min
    * $max
    * $mul

### Update methods

#### updateOne

It finds the first document that matches the filter criteria and perform required updation. It will perform updation for a single document.

> Syntax: `db.collection.updateOne(filter, update, options)`

#### #### updateMany

To update all documents that match the specfied filter criteria.

> Syntax: `db.collection.update(filter, update, options)`

#### update

We can use this method to update either a single document or multiple documents. By default it updates query matched single document only.

> Syntax: `db.collection.update(filter, update, options: {multi: true})`

```js
use abcDB
db.createCollection("employees")

db.employees.insertOne({_id:1, eno: 100, ename: "Sunny", esal: 1000, eaddr: "Mumbai"}) 
db.employees.insertOne({_id:2, eno: 200, ename: "Bunny", esal: 2000, eaddr: "Hyderabad"}) 
db.employees.insertOne({_id: 3, eno: 300, ename: "Chinny", esal: 3000, eaddr: "Mumbai"}) 
db.employees.insertOne({_id:4, eno: 400, ename: "Vinny", esal: 4000, eaddr: "Delhi"}) 
db.employees.insertOne({_id: 5, eno: 500, ename: "Pinny", esal: 5000, eaddr: "Chennai"}) 
db.employees.insertOne({_id: 6, eno: 600, ename: "Tinny", esal: 6000, eaddr: "Mumbai"}) 
db.employees.insertOne({_id:7, eno: 700, ename: "Zinny", esal: 7000, eaddr: "Delhi"})

// update sunny's salary
db.employees.updateOne({_id: 1}, {$set: {esal: 99899}})

// update all mumbai based employees salary to 7777?
db.employees.updateMany({eaddr: "Mumbai"}, {$set: {esal: 7777}})

// update all delhi based employees salary to 8585?
db.employees.update({eaddr: "Delhi"}, {$set: {esal: 8585}}, {multi: true})
```

### Update operators

#### $set

we can use `$set` operator to set the value of the field in matched document.

If the specifed field doesn't exist, `$set` will add a new field with provided value.

```js
// update sunny document
db.employees.updateOne({_id: 1}, {$set: {husband: "daniyel"}})

// update documents where esal >= 4000
db.employees.update({esal: {$gte: 4000}}, {$set: {friend: "guest"}}, {multi: true})
```

#### $unset

To delete the specified field

> Syntax: `db.employees.update(query, {$unset: {field: "", field2: ""}})`

The specfied value in the `$unset` expression `""` doesn't impact operation.

```js
// delete esal and husband fields where ename is Sunny?
// if the specfied field is not avaiable to delete, no error wil be thrown
db.employees.update({ename: "Sunny"}, {$unset: {esal: 0, husband: ""}})

// remove fields husband and friend where esal is < 8000
db.employees.update({esal: {$lt: 8000}}, {$unset: {husband: "", friend: ""}}, {multi: true})
```

#### $rename

We can use `$rename` to rename the field 

> Syntax: `db.collection.updateOne(query, {$rename: {oldFieldName: newName, ....}})`

```js

// if the required $rename field doesn't exist in document then nothing will happen/no error will be thrown

// how $rename internally behaves?
// first query matching operation then internally store $rename fields's value to somewhere then 
// $unset operation performs on $rename fields, then $set operation performs with new field and stored value.

// rename esal as salary and eaddr as city?
db.employees.updateMany(
    {},
    {$rename: {
        esal: "salary",
        eaddr: "city"
    }}
)

// rename eaddr to city?
{
    no: 1000,
    salary: 100,000
    city: "KK",
    eaddr: "Moscow"
}

// first eaddr's value will be stored in memory, then $unset operation will be performed
// on eaddr and city (new name, if exist). Then $set operation will be happened as city: "Moscow"
{
    no: 1000,
    salary: 100,000
    city: "Moscow"
}
```

#### $inc

To perform increment or decrement of field value with specified amount. If amount is positive then increment, if amount is negative then decrement.

> Syntax: `db.collection.update(query, {$inc: {key: value}})`

```js
// increment all employees salary by 5000 (bonus)
db.employees.updateMany({}, {$inc: {esal: 5000}})

// decrement salary 1000 for sunny
db.employees.updateOne({ename: "Sunny"}, {$inc: {esal: -1000}})

// if the specified field doesn't exist, $inc creat that field and sets that field to specfied value.
db.employees.updateOne({}, {$inc: {age: 2}})

// Error, multiple update on same field at a time. perform one operation on same field at a time
db.employees.updateeMany(
    {},
    {
        $inc: {
            esal: 5000
    },
        $set: {
            esal: 50000
    }
})
```

#### $min

`$min` operator updates the value of the field to specified value if specified value is < current value. If field doesn't exist it will create new one and perform `$set` operation.

* $min(providedValue, currentValue)
    * $min(1000, 2000) -- 1000

> Syntax: `db.collection.update(query, {$min: {key: value}...})`

```js
db.employees.updateMany({}, {$min: {esal: 200}})
```

#### $max

`$max` operator updates the value of the field to specified value if specified value is > current value. If field doesn't exist it will create new one and perform `$set` operation.

* $max(providedValue, currentValue)
    * $max(4000, 2000) -- 4000

> Syntax: `db.collection.update(query, {$max: {key: value}...})`

```js
db.employees.updateMany({}, {$max: {esal: 200,000}})

// but don't want to add field if its not exist, then check first its exist or not then perform operation
db.employees.update({age: {$exists: true}}, {$set: {age: 45}}, {multi: true})
```

#### $mul

mul means perform multiplication operation. If the specified field is not available then $mul creates that field and sets the value to 0.

> Syntax: `db.collection.update(query, {$mul: {key: n}...})`

```js
// double all employees salary as covid bonus 
db.employees.updateMany({}, {$mul: {esal: 2}})
```

### upsert property

upsert means  = update + insert. If field is available then update else insert a new document with the values

> Syntax: `db.collection.update(query, updateOperation, {upsert: true})`

Whenever we are trying to perform update operation, the matched document may or many not be available. If it is available then it will be updated else won't update. If the document is not available then we can insert that document automatically by using set `{upsert: true}`. Default is `false`

```js
db.employees.updateOne({ename: "Mallika"}, {$set: {_id: 11, esal: 9999, eaddr: "Pandychari"}}, {upsert: false})
// WriteResult({nMatched: 0, nUpserted: 0, nModified: 0})

db.employees.updateOne({ename: "Mallika"}, {$set: {_id: 11, esal: 9999, eaddr: "Pandychari"}}, {upsert: true})
// WriteResult({nMatched: 0, nUpserted: 1, nModified: 0})
```

### Array Update Operation