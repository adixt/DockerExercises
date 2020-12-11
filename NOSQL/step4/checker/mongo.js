use myDatabase
db.books.find(
    {"publishedDate": 
        {$gt: ISODate("2014-06-10"), 
        $lt: ISODate("2014-06-15")}
    },
    {"publishedDate":1, "title":1, "_id":0}
)