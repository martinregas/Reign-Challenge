//
//  PostsDBHelper.swift
//  Reign Challenge
//
//  Created by Martin Regas on 21/10/2020.
//

import Foundation
import SQLite3

class PostsDBHelper: DBHelper {
    override init() {
        super.init()
        createTable(type: .post)
        createTable(type: .deletedPost)
    }
}

//MARK: PostsDBProtocol
extension PostsDBHelper: PostsDBProtocol {
    func createTable(type:DBTableType) {
        let createTableString = "CREATE TABLE IF NOT EXISTS \(type.name)(id INT, title TEXT,author TEXT,url TEXT, date, TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("post table created.")
            } else {
                print("post table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(type:DBTableType, id:Int, title:String, author:String, url:String, date:String)
    {
        let insertStatementString = "INSERT INTO \(type.name) (id, title, author, url, date) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (author as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (url as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (date as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read(type:DBTableType) -> [Post] {
        let queryStatementString = "SELECT * FROM \(type.name);"
        var queryStatement: OpaquePointer? = nil
        var psns : [Post] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let author = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let url = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))

                psns.append(Post(id: id, title: title, author: author, url: url, date: date))
                print("Query Result:")
                print("\(title) | \(author) , | \(url) , | \(date) ")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func clear(type:DBTableType) {
        let deleteStatementStirng = "DELETE FROM \(type.name)"

        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func deleteByID(type:DBTableType, id:Int) {
        let deleteStatementStirng = "DELETE FROM \(type.name) WHERE id = ? AND title = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
