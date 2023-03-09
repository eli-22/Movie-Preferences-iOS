//
//  ClientData.swift
//  Elise
//
//  Created by Elise on 9/29/22.
//

import Foundation

struct Client: CustomStringConvertible, Comparable, Equatable {
    var clientNumber: Int
    var clientEmail: String
    var preferredGenres: [Genre]
    
    func displayGenres(_ preferredGenres: [Genre]) -> String {
        var returnString = ""
        for item in preferredGenres {
            returnString += "\n\(item.rawValue)"
        }
        return returnString
    }
    
    var description: String {
        return "Client Number: \(clientNumber)\nEmail: \(clientEmail)\nPreferred Genres: \(displayGenres(preferredGenres))\n"
    }
    
    static func == (lhs: Client, rhs: Client) -> Bool {
        return (lhs.clientNumber == rhs.clientNumber)
    }
    
    static func < (lhs: Client, rhs: Client) -> Bool {
        return lhs.clientEmail < rhs.clientEmail
    }
}

enum Genre: String {
    case action = "Action", comedy = "Comedy", drama = "Drama"
}
