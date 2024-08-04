> [Official Cheat Sheet](https://www.mongodb.com/developer/products/mongodb/cheat-sheet/)

# Operations Syntax

## 0. Miscellaneous Operations

### Drop a Database

```jsx
db.dropDatabase()
```

### List Collections

```jsx
db.listCollections().toArray()
```

### List Databases

```jsx
db.adminCommand({ listDatabases: 1 })
```

## 1. Insert Operations

### Insert a Single Document

```jsx
// db.collection.insertOne(document)
db.collection.insertOne({
  field1: value1,
  field2: value2
})
```

### Insert Multiple Documents

```jsx
// db.collection.insertMany([document1, document2, ...])
db.collection.insertMany([
  { field1: value1, field2: value2 },
  { field1: value1, field2: value2 }
])
```

## 2. Retrieve Operations

### Find One Document

```jsx
// db.collection.findOne(query)
db.collection.findOne({ field: value })
```

### Find Multiple Documents

```jsx
// db.collection.find(query)
db.collection.find({ field: value })

// To get results as an array
db.collection.find({ field: value }).toArray()
```

### Find with Projection

```jsx
// db.collection.find(query, projection)
db.collection.find(
  { field: value },
  { projection: { field1: 1, field2: 1, _id: 0 } }
)
```

### Find with Sorting

```jsx
// db.collection.find(query).sort(sort)
db.collection.find({ field: value }).sort({ field: 1 })
// 1 for ascending, -1 for descending
```

### Find with Limiting and Skipping

```jsx
// db.collection.find(query).limit(n)
db.collection.find({ field: value }).limit(5)

// db.collection.find(query).skip(n)
db.collection.find({ field: value }).skip(10)
```

## 3. Update Operations

### Update a Single Document

```jsx
// db.collection.updateOne(filter, update, options)
db.collection.updateOne(
  { field: value },
  { $set: { fieldToUpdate: newValue } }
)
```

### Update Multiple Documents

```jsx
// db.collection.updateMany(filter, update, options)
db.collection.updateMany(
  { field: value },
  { $set: { fieldToUpdate: newValue } }
)
```

### Replace a Single Document

```jsx
// db.collection.replaceOne(filter, replacement, options)
db.collection.replaceOne(
  { field: value },
  { field1: newValue1, field2: newValue2 }
)
```

### Upsert Operation

```jsx
// db.collection.updateOne(filter, update, { upsert: true })
db.collection.updateOne(
  { field: value },
  { $set: { fieldToUpdate: newValue } },
  { upsert: true }
)
```

## 4. Delete Operations

### Delete a Single Document

```jsx
// db.collection.deleteOne(filter)
db.collection.deleteOne({ field: value })
```

### Delete Multiple Documents

```jsx
// db.collection.deleteMany(filter)
db.collection.deleteMany({ field: value })
```

### Drop a Collection

```jsx
db.collection.drop()
```

# Operators Syntax

## 1. Query Operators

### Comparison Operators

```jsx
// $eq: Equal to
{ field: { $eq: value }}

// $ne: Not equal to
{ field: { $ne: value }}

// $gt: Greater than
{ field: { $gt: value }}

// $gte: Greater than or equal to
{ field: { $gte: value }}

// $lt: Less than
{ field: { $lt: value }}

// $lte: Less than or equal to
{ field: { $lte: value }}

// $in: In an array
{ field: { $in: [value1, value2, ...]} }

// $nin: Not in an array
{ field: { $nin: [value1, value2, ...]} }
```

### Logical Operators

```jsx
// $and: Logical AND
{ $and: [{ condition1 }, { condition2 }] }

// $or: Logical OR
{ $or: [{ condition1 }, { condition2 }] }

// $nor: Logical NOR
{ $nor: [{ condition1 }, { condition2 }] }

// $not: Logical NOT
{ field: { $not: { $condition }} }
```

### Element Operators

```jsx
// $type: Data type of the field
{ field: { $type: "type" }}

// $exists: Field existence
{ field: { $exists: true/false }}
```

### Evaluation Operators

```jsx
// $regex: Regular expression pattern
{ key: {$regex: /pattern/, $options: "i"}}
{ key: {$regex: /pattern/i}} 
{ key: {$regex: "pattern", $options: "i"}}
{ key: /pattern/i }

// $expr: Compare 2 fields within the document
{ $expr: {expression}}

// $mod: Modulo Operation
{ key: {$mod: [divisor, reminder]}
```

### Array Operators

```jsx
// $all: All elements match
{ field: { $all: [value1, value2, ...]} }

// $elemMatch: Match array elements
{ field: { $elemMatch: { condition }} }

// $size: Array size
{ field: { $size: number }}
```

## 2. Projection Operators

```jsx
// $: Positional operator
{ "field.$": 1 }

// $elemMatch: Project specific array elements
{ field: { $elemMatch: { condition }} }
```

## 3. Update Operators

```jsx
// $set: Set value
{ $set: { field: value }}

// $unset: Remove field
{ $unset: { field: "" }}

// $inc: Increment value
{ $inc: { field: amount }}

// $mul: Multiply value
{ $mul: { field: multiplier }}

// $rename: Rename field
{ $rename: { oldField: newField }}

// $min: Set value if it is less than current value
{ $min: { field: value } }

// $max: Set value if it is greater than current value
{ $max: { field: value } }

// $currentDate: Set field to current date
{ $currentDate: { field: { $type: "date" }} }
```

## 4. Aggregation Operators

### Arithmetic Operators

```jsx
// $add: Addition
{ $add: [value1, value2, ...]}

// $subtract: Subtraction
{ $subtract: [value1, value2]}

// $multiply: Multiplication
{ $multiply: [value1, value2, ...]}

// $divide: Division
{ $divide: [value1, value2] }
```

### String Operators

```jsx
// $concat: Concatenate strings
{ $concat: [string1, string2, ...] }

// $toUpper: Convert to uppercase
{ $toUpper: "string" }

// $toLower: Convert to lowercase
{ $toLower: "string" }

// $substr: Substring
{ $substr: [string, start, length] }
```

### Date Operators

```jsx
// $dateToString: Format date as string
{ $dateToString: { format: "format", date: "date" } }

// $year: Extract year
{ $year: "date" }

// $month: Extract month
{ $month: "date" }

// $dayOfMonth: Extract day of month
{ $dayOfMonth: "date" }
```

### Array Operators

```jsx
// $first: First element
{ $first: "arrayField" }

// $last: Last element
{ $last: "arrayField" }

// $filter: Filter array elements
{ $filter: { input: "arrayField", as: "item", cond: { $eq: [ "$$item.field", value ]}} }
```

# Cursor Methods

## 1. Basic Cursor Methods

### next()

**Description:** Retrieves the next document from the cursor.

```jsx
var cursor = db.collection.find()
var doc = cursor.next()
```

### hasNext()

**Description:** Checks if there are more documents in the cursor.

```jsx
var cursor = db.collection.find()
if (cursor.hasNext()) {
  // Do something}
```

### forEach(callback)

**Description:** Iterates over each document in the cursor and applies the specified callback function.

```jsx
db.collection.find().forEach(function(doc) {
  print(doc)
})
```

### toArray()

**Description:** Converts the cursor to an array of documents.

```jsx
var docs = db.collection.find().toArray()
```

## 2. Cursor Methods for Pagination

### limit(n)

**Description:** Limits the number of documents returned by the cursor.

```jsx
var cursor = db.collection.find().limit(5)
```

### skip(n)

**Description:** Skips the first `n` documents of the cursor.

```jsx
var cursor = db.collection.find().skip(10)
```

### batchSize(n)

**Description:** Sets the number of documents to be retrieved in each batch when iterating.

```jsx
var cursor = db.collection.find().batchSize(20)
```

## 3. Cursor Methods for Sorting and Projection

### sort(sort)

**Description:** Sorts the documents in the cursor according to the specified sort criteria.

```jsx
var cursor = db.collection.find().sort({ field: 1 }) // 1 for ascending, -1 for descending
```

### project(projection)

**Description:** Limits the fields of documents that are returned.

```jsx
var cursor = db.collection.find().project({ field1: 1, field2: 1, _id: 0 })
```

## 4. Cursor Methods for Aggregation

### map(callback)

**Description:** Applies a mapping function to each document and returns a new cursor with the results.

```jsx
var cursor = db.collection.find().map(function(doc) {
  return { field: doc.field * 2 }
})
```

### toArray()

**Description:** Converts the cursor to an array of documents.

```jsx
var results = db.collection.aggregate(pipeline).toArray()
```

## 5. Cursor Methods for Tailable Cursors

### isTailable()

**Description:** Checks if the cursor is a tailable cursor.

```jsx
var cursor = db.collection.find().addOption(DBQuery.Option.tailable)
print(cursor.isTailable())
```

### addOption(option)

**Description:** Adds an option to the cursor, such as DBQuery.Option.tailable for tailable cursors.

```jsx
var cursor = db.collection.find().addOption(DBQuery.Option.tailable)
```

## 6. Cursor Methods for Resuming Cursors

### setReadPreference(readPreference)

**Description:** Sets the read preference for the cursor.

```jsx
var cursor = db.collection.find().setReadPreference("secondaryPreferred")
```

### rewind()

**Description:** Rewinds the cursor to the beginning.

```jsx
// deprecated
cursor.rewind()
```

## 7. Cursor Methods for Profiling and Debugging

### explain([verbosity])

**Description:** Provides information on the query execution plan. Can be used with different verbosity levels.

```jsx
var explanation = db.collection.find().explain("executionStats")
```


