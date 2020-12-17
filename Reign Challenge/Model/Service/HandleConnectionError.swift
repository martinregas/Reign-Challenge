//
//  HandleError.swift
//  Reign Challenge
//
//  Created by Martin Regas on 21/10/2020.
//

import Foundation

struct HandleConnectionError {
    static func handle(error:URLError) -> String {
        switch error.code {
            case .timedOut:
                return "Timed out error"
            case .notConnectedToInternet:
                return "Check your internet connection"
            default:
                return "An error has occurred"
        }
    }
}

