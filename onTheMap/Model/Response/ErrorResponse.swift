//
//  ErrorResponse.swift
//  onTheMap
//
//  Created by Waiel Eid on 9/5/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import Foundation


struct ErrorResponse: Codable {
    let status: Int
    let error: String
}
