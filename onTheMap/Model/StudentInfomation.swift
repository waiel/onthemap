//
//  StudentInfomation.swift
//  onTheMap
//
//  Created by Waiel Eid on 9/5/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String

    let longitude: Double
    let latitude: Double
        
}
