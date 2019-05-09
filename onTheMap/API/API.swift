//
//  API.swift
//  onTheMap
//
//  Created by Waiel Eid on 8/5/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import Foundation


class API {

    static let parseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let parseResetApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    
    enum Endpoints {
       static let udacityBaseURL: String = "https://onthemap-api.udacity.com/v1/"
       static let parseBaseURL: String = "https://parse.udacity.com/parse/classes"
        
        
        case login
        case logout
        case getStudentsLocations(limit: Int)
        
        var stringValue:String {
            switch self {
            case .login:
                return  Endpoints.udacityBaseURL + "session"
            case .logout:
                return Endpoints.udacityBaseURL + "session"
            case .getStudentsLocations(let limit):
                return Endpoints.parseBaseURL + "?limit=\(limit)&&order=-updatedAt"
            }
        }
        
        var url: URL{
            return URL(string: stringValue)!
        }
    }
    
}


func login(username: String, password: String, completion: @escaping (Bool, Error?)-> Void) {
    
    let body = SessionLogin(udacity: credentials(username: username, password: password))
   
    taskForPOSTRequest(url: API.Endpoints.login.url, responseType: SessionResponse.self, body: body) {(response, error) in
        if let response = response {
            Auth.sessionId = response.session.id
            Auth.key = response.account.key
            completion(true, nil)
        } else {
            completion(false, error)
        }
    }
}


func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONEncoder().encode(body)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    // authorization header key
    request.addValue(API.parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue(API.parseResetApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            completion(nil, error)
            return
        }
        
        let decoder = JSONDecoder()
        
        let newData = data.subdata(in: 5..<data.count)
        print(String(data: newData, encoding: .utf8)!)
        
        do {
            let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                    return
              }
        } catch {
            do {
                let errorResponse = try decoder.decode(ErrorResponse.self, from: newData)
                DispatchQueue.main.async {
                    completion(nil, errorResponse as? Error)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, "Unknow Error" as? Error)
                }
            }
        }
    }
    task.resume()
}
