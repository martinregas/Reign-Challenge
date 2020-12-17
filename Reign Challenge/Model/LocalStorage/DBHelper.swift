//
//  PostsListViewController.swift
//  Reign Challenge
//
//  Created by Martin Regas on 17/10/2020.
//

import Foundation
import SQLite3

class DBHelper {
    init()
    {
        db = openDatabase()
    }
    
    let dbPath: String = "ReignChallenge.sqlite"

    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
}
