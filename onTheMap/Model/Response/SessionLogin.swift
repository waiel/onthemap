//
//  SessionLogin.swift
//  onTheMap
//
//  Created by Waiel Eid on 9/5/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import Foundation
struct SessionLogin: Codable {
    let udacity: credentials
}
struct credentials: Codable {
    let username: String
    let password: String
}
