//
//  SessionResponse.swift
//  onTheMap
//
//  Created by Waiel Eid on 8/5/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    var account: Account
    var session: Session
}

struct Account: Codable {
    var registered: Bool
    var key: String
}
struct Session: Codable {
    var id: String
    var expiration: String
}
