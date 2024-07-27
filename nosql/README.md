<a href="https://www.durgasoftonline.com/courses/MongoDB-New-Batch-Videos-18th-DEC-8-AM-by-Durga-Sir-5fe2bdfc0cf2817f67426bcc"><img src="https://i.ibb.co/kSkJQKk/image.png" alt=""></a>

> Compiler: https://www.mycompiler.io/new/mongodb

MongoDB comes from Humongous, it means Extremely large. It can handle large amount of data.

MongoDB database vendor is MongoDB. We can use MongoDB anywhere (mobile, desktop, cloud). MongoDB is JavaScript based and behind the scene it uses Mozilla Spider Monkey engine.

### Stack

The technologies which can be used to develop web applications are called stack. 2 stacks are very popular with MongoDB.

* MERN - MongoDB, Expressjs, Reactjs, Nodejs
* MEAN - MongoDB, Expressjs, Angularjs, Nodejs

> MongoDB is document based aka NoSQL database.

This database contains multiple collections (table in SQL) and each collection contains multiple documents (rows in SQL). Data is stored in separate documents and each document is independent of others.

### Structure

MongoDB physical database contains several logical databases. Each database contains several collections (table) and each collection contains several documents. Documents are like record/row in SQL database.

### Examples

- Shopping Cart database
    - Customers, Products (collections)
        - Each customer's full information. (document)
        - Each Product's full information.

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
  "name": "John Doe"
}
```

> Performance and flexibility is the biggest assets of MongoDB

### Key Characteristics 

- Installation and setup is very easy.
- All information related to a document will be stored in a single place. To retrieve data, it is not required to perform join operations and hence retrieval is very fast.
- Documents are independent of each other and no fixed schema. Hence we can store unstructured data like videos, audio files etc.
- We can perform operations like update existing document, delete document and inserting new documents very easily.
- Retrieval data is in the form of JSON which can be understandable by any programming language.
- We can store very huge amount of data and hence scalability is more.

### Theory

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

### Installation

* [MongoDB Community Edition](https://www.mongodb.com/try/download/community)

> you must have to add `mongodb bin` path in the environment variable.

To store data you must have to create `data/db` directory inside a Drive (C/D/E or whatever) and run the following `mongod` command to start the MongoDB shell from the same drive.

you can also specify other location via `mongod --dbpath "location"`

`mongod` is the command where you will store the data and `mongo` is command line tool to perform operations.

```js
$ mongo // shell started
$ db.version()
$ show dbs // list of default databases
$ use abcDB // switch to abcDB database
$ show collections // display all collections from a particular database
```

- Default Databases `show dbs`
- admin
    - It is used to store authentication & authorization information.
    - Used by administrator to perform users CRUD Operations and assign roles.
- config
    - To store config information of mongoDB server
- local
    - It is used by admin while performing replication process.

### Data Formats

* Client write JavaScript objects/JSON but MongoDB server stores them as BSON format.

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

### ObjectId

For every document MongoDB server is associated with a unique ID, which is ObjectId. It behaves like primary key in relational databases. ObjectId is assigned to `_id` field. It is BSON type.

```js
{
    _id: ObjectId("random string")
}
```

* ObjectId is 12 bytes
    * first 4 bytes represents the timestamp when the documents was inserted
    * next 3 bytes represents machine id (host name)
    * the next 2 bytes represents process id
    * last 3 bytes represents random incremental value

#### Generate Timestamp from ObjectId

* `db.collection.findOne()._id.getTimestamp()` - when this documents was created

By using `_id` field, we can provide its value. MongoDB server will generate its value (immutable ObjectId, which is unique per collection), if we do not provide any `_id` value. Duplicate `_id` is not possible.

### CRUD Operation

#### Insertion

There are 3 ways to insert documents into the collections

- `db.collection.insert()` -- deprecated
- `db.collection.insertOne({JS object})`
- `db.collection.insertMany([{}, {}])`

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

#### Retrieval

There are 2 ways to read data from the collections

- `db.collection.find({optional: condition})`
    - default is all documents, if condition is absence.
- `db.collection.findOne({optional: condition})`
    - default is first document, if condition is absence.

```js
db.Employees.find()
db.Employees.find().pretty() // readable format

db.Employees.find().forEach((doc) => {
    printjson(doc)
})

let employee = db.Employees.findOne() // return 1st document
printjson(employee)
```

#### Update

There are 3 ways to update documents

- `db.collection.updateOne({condition: value}, {$set: {key: value}})`
- `db.collection.updateMany()`
- `db.collection.replaceOne()`

```js
db.Employees.updateOne({"ename": "John Doe"}, {$set: {"eaddress": "New Delhi"}})
db.Employees.find()
```

if `eaddress` doesn't exist in the document then it will create new `eaddress` property else replace old value with new value.

#### Deletion

There are 2 ways to delete data from the collections

- `db.collection.deleteOne()`
- `db.collection.deleteMany()`

```js
db.abcdDB.insertOne({
    "hello": "World",
    "city": "Moscow"
})

db.abcdDB.deleteOne({"hello": "World"})
```

### Capped Collection

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
db.Orders.find().pretty() // soap
```

### Insert documents from JavaScript file

```js
use studentDB

db.createCollection("students");
load('js-file-path.js')

db.students.find()
```

### Insert documents from JSON file

* The data should be in the array form - `[{}, {}]`
* Data must be valid JSON.

##### Steps

* `$ mongod` -> start mongoDB server
* `$ mongo` -> start mongoDB shell
* `$ mongoimport` -> to import json file | by default it is not available, install manually
    * https://www.mongodb.com/try/download/database-tools
    * https://www.mongodb.com/docs/database-tools/
    * copy `mongoimport.exe` file & paste it `mongoDB/server/version/bin/`
    * open a new command prompt and go to where json file is available

```shell
# mongoimport will create database and collections if they aren't available.
# if collection is already available, new documents will be appened
$ mongoimport --db dbName --collection collectionName --file ./json-file-path.json --jsonArray
```

### Nested Documents

Sometimes we can take a document inside another documents, these type of dcouments are called nested documents or embedded documents. MongoDB supports 100 level of nesting.

```json
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

### Ordered Insertion in Bulk insert

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

By default, while performing bulk inserts if any of the object raise an error, rest of the objects won't be inserted. But the objects which are already inserted won't be roll back. [previous objects - inserted] -> insertion fail -> [next objects - won't be inserted]

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

### Atomicity

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

### writeConcern

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

### Reading data

We can fetch documents from the collection by using following methods

* `db.collection.find({ key: value })`
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

#### Querying nested documents

If the value of a field again a document then nested property values we can access via `.` operator. In this case, key must be enclosed with quotes.

* List out all documents where author's `callname` is `Neo`?
    * `db.books.find({ "author.callname": "Neo" })`
* List out all documents where author's profile contains `2` courses?
    * `db.books.find({ "author.profile.courses": 2 })`

#### Querying Arrays

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

### Query Operators

Every operator prefix with `$` symbol.

#### Comparison Operators

- $lt
- $lte
- $gt
- $gte
- $ne
- $eq
- $in
- $nin

Syntax: `db.collection.find({ key: {operator: value} })`

##### $eq

The `$eq` operator matches documents where the value of the field is equal to specified value.

Syntax: `db.collection.find({ key: {$eq: value} })`  
Shortcut Syntax: `db.collection.find({ key: value })`

* Select all documents where `no_of_reviews` is 3?
    * `db.books.find({ no_of_reviews: {$eq: 3} })`
* Select all documents where author's profile contains 2 courses?
    * `db.books.find( {"author.profile.courses": {$eq: 2} }).pretty()`
* Select all documents where `tags` array contains `database` element?
    * `db.books.find({ tags: {$eq: "database"} }).pretty()`
* Select all documents where `tags` array is exactly as `["language", "freeware", "programming"]`
    * `db.books.find({ tags: {$eq: [language", "freeware", "programming"]} })`

##### $ne

`$ne` means not equal. We can use `$ne` operator to select all documents where the value of the field is not equal to specified value.

Syntax: `db.collection.find({ key: {$ne: value} })`

* Select all documents where `no_of_reviews` not 3?
    * `db.books.find({ no_of_reviews: {$ne: 3} })`

If the specified `field` is not present in the document, that document will also be included. Only happens when we perform `not equal/ not in` action.

##### $gt

`$gt` means greater than operator. We can use `$gt` operator to select all documents where the value of key is `>` specified value.

Syntax: `db.collection.find({ key: {$gt: value} })`

* Select all documents where `no_of_reviews` are greater than 3?
    * `db.books.find({ no_of_reviews: {$gt: 3} })`

##### $gte

`$gte` means greater than or equal to operator. We can use `$gte` operator to select all documents where the value of key is `>=` specified value.

Syntax: `db.collection.find({ key: {$gte: value} })`

* Select all documents where `no_of_reviews` are greater than or equal to 3?
    * `db.books.find({ no_of_reviews: {$gte: 3} })`

##### $lt

`$lt` means less than operator. We can use `$lt` operator to select all documents where the value of key is `<` specified value.

Syntax: `db.collection.find({ key: {$lt: value} })`

* Select all documents where `no_of_reviews` are less than 3?
    * `db.books.find({ no_of_reviews: {$lt: 3} })`

##### $lte

`$lte` means less than or equal to operator. We can use `$lte` operator to select all documents where the value of key is `<=` specified value.
 
Syntax: `db.collection.find({ key: {$lte: value} })`

* Select all documents where `no_of_reviews` are less than or equal to 3?
    * `db.books.find({ no_of_reviews: {$lte: 3} })`

##### $in

We can use `$in` operator to select all documents where the value of a field  equals any value in specified array.

Syntax: `db.collection.find({ key: {$in: [value1, value2, value3...]} })`

* Select all documents where `no_of_reviews` in `[1, 4, 5]`?
    * `db.books.find({ no_of_reviews: {$in: [1, 4, 5]} })`
* Select all documents where `tags` array contains `database` or `programming`
    * `db.books.find( {tags: {$in: ["database", "programming"] }} )`

##### $nin

We can use `$nin` operator to select all documents where the value of a field not present in specified array.

* `$nin` operator will select:
    * the field value doesn't present in specified array.
    * the field doesn't exist.

Syntax: `db.collection.find({ key: {$nin: [value1, value2, value3...]} })`

* Select all documents where `no_of_reviews` not in `[1, 4, 5]`?
    * `db.books.find({ no_of_reviews: {$nin: [1, 4, 5]} })`
* Look at the query `db.books.find({exams: 5}).count()`
    * all documents will return, cause `exams` is not a valid field in the books collection

#### Logical Operators

- $or
- $and
- $not
- $nor

##### $or Operator

`$or` performs logical or operator on an array of 2 or more conditions and selects the documents that satisfy at least one condition.

Syntax: `db.collection.find({ $or: [condition1, condition2, conditionN] })`

* Select all documents where tags array contains `programming` or `no_of_reviews > 3`?
    * `db.books.find({ $or: [{ no_of_reviews: {$gt: 3} }, { tags: {$in: "programming"} }] })`
* Select all documents where either `no_of_reviews < 3` or `{downloadable: true}` or `author` profile contains at least `2` books?
    * `db.books.find({ $or: [ {no_of_reviews: {$lt: 3}}, {downloadable: {$eq: true}}, {"author.profile.books": {$gte: 2}} ] })`

##### $nor Operator

It is inverse of `$or` Operator. $nor` performs a logical NOR operation on an array of one or more conditions and selects the documents that fails all query condition.

- $or: At least one condition is satisfied
- $nor: Neither condition is satisfied aka all condition fails

Syntax: `db.collection.find({ $or: [condition1, condition2, conditionN] })`

Look at the below query

```js
db.books.find({ $nor: [{no_of_reviews: {$gt: 3}}, {downloadable: true}] })
```

It selects the documents where below conditions (both in a single document) are matched.

- The `no_of_reviews` is less than or equal to 3
- `downloadable` is false
- It also picks up such documents that don't contain neither `no_of_reviews` nor `downloadable` fields.

#### $and Operator

`$and` performs logical AND Operation on an array of one or more expressions and selects the documents that satisfy all expressions in the array.

Syntax: `db.collection.find({$and: [condition1, condition2, conditionN]})`   
Shortcut Syntax: `db.collection.find({ field1: value1, field2: value2 })`

* Select all documents where `no_of_reviews <= 3` and `{downloadable: true}`
    * `db.books.find( $and: [{no_of_reviews: {$gte: 3}}, {downloadable: true}] )`

```js
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
```

* Select all documents where `marks` are less than 85 and greater than 45?
    * `db.students.find( $and: [{marks: {$gt: 45}}, {marks: {$lt: 85}}] )`
    * `db.students.find( {marks: {$gt: 45}, marks: {$lt: 85}} )`
    * if both conditions are on same field `{ marks: < 50, marks: >= 35 }`, then shortcut syntax won't work as expected. Because duplicate keys are not allowed in JS object.

##### $not Operator

`$not` operator performs logical NOT operation on the specified operator expression and selects the documents that do not match operator expression. This includes also the documents that don't contain the field.

Syntax: `db.collection.find({ key: {$not: {$gt: value}} })`

Look at the query `db.students.find( {marks: {$not: {$gt: 55}}})`

* Above query will return the following documents
    * where `marks >= 55`.
    * `marks` field doesn't exist in the document.

#### Element Query Operators

##### $exists

Syntax: `db.collection.find({ key: {$exists: <boolean>} })`

- If `boolean=true` then select all documents that contain specified field even value of the field is `null`.
- If `boolean=false` then select all documents that don't contain specified field.

* Select all fields which contains `no_of_reviews` field?  
    * `db.collection.find({ no_of_reviews: {$exists: true} })`
* Select all fields which don't contains `no_of_reviews` field?    
    * `db.collection.find({ no_of_reviews: {$exists: false} })`
* Select all documents which contains `gf` field also `marks` are higher than 70?  
    * `db.collection.find({ gf: {$exists: true}, marks: {$gt: 70} })`

##### $type

`$type` operator selects the documents where value of a field is of a particular type. We've to specify the type as BSON type.

Syntax: `db.collection.find({key: {$type: <bson type>}})`  
Syntax: `db.collection.find({key: {$type: [<bson type1>, <bosn type2]}})`

> we can specify either number or alias name for BSON type

![available-types](https://i.ibb.co/0Q4ThZS/image.png)

`$type` also supports "number" alias which will match following types - int, long, double, decimal.

> double is 64 bits & decimal is 128 bits floating point value.

```js
use phoneDB;
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

