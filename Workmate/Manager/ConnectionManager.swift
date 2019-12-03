//
//  ConnectionManager.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation

class ConnectionManager{
    static func auth(username:String, password:String, completion: @escaping (Key?, Error?)-> Void){
        let session = URLSession(configuration: .default)
        let json:[String:Any] = ["username":username, "password":password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let components = URLComponents(string: "\(ConstantManager.baseUrl)/auth/login/")!
        var request = URLRequest(url: components.url!)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { (data, response, err) in
            if let error = err{
                completion(nil, error)
            }else if let unwrappedData = data{
                do{
                    let response = try JSONDecoder().decode(Key.self, from: unwrappedData)
                    completion(response,nil)
                }catch{
                    completion(nil,error)
                }
            }
        }
        task.resume()
    }
    
    static func getStaffRequest(completion: @escaping (StaffRequest?, Error?)-> Void){
        let session = URLSession(configuration: .default)
        let components = URLComponents(string: "\(ConstantManager.baseUrl)/staff-requests/26074/")!
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { (data, response, err) in
            if let error = err{
                completion(nil, error)
            }else if let unwrappedData = data{
                do{
                    let response = try JSONDecoder().decode(StaffRequest.self, from: unwrappedData)
                    completion(response,nil)
                }catch{
                    completion(nil,error)
                }
            }
        }
        task.resume()
    }
    
    static func clockIn(lat:String, lng:String, completion: @escaping (ClockedIn?,ClockedError?, Error?)-> Void){
        guard let key = Util.shared.getAuthKey() else { return }
        let session = URLSession(configuration: .default)
        let json:[String:Any] = ["latitude":lat, "longitude":lng]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let components = URLComponents(string: "\(ConstantManager.baseUrl)/staff-requests/26074/clock-in/")!
        var request = URLRequest(url: components.url!)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic \(key)", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request) { (data, response, err) in
            if let error = err{
                completion(nil, nil,error)
            }else if let unwrappedData = data{
                do{
                    let response = try JSONDecoder().decode(ClockedIn.self, from: unwrappedData)
                    completion(response,nil,nil)
                }catch{
                    do{
                        let response = try JSONDecoder().decode(ClockedError.self, from: unwrappedData)
                        completion(nil,response,nil)
                    }catch{
                        completion(nil, nil,error)
                    }
                }
            }
        }
        task.resume()
    }
    
    static func clockOut(lat:String, lng:String, completion: @escaping (ClockedOut?, ClockedError?,Error?)-> Void){
        guard let key = Util.shared.getAuthKey() else { return }
        let session = URLSession(configuration: .default)
        let json:[String:Any] = ["latitude":lat, "longitude":lng]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let components = URLComponents(string: "\(ConstantManager.baseUrl)/staff-requests/26074/clock-out/")!
        var request = URLRequest(url: components.url!)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic \(key)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (data, response, err) in
            if let error = err{
                completion(nil, nil,error)
            }else if let unwrappedData = data{
                do{
                    let response = try JSONDecoder().decode(ClockedOut.self, from: unwrappedData)
                    completion(response,nil,nil)
                }catch{
                    do{
                        let response = try JSONDecoder().decode(ClockedError.self, from: unwrappedData)
                        completion(nil,response,nil)
                    }catch{
                        completion(nil, nil,error)
                    }
                }
            }
        }
        task.resume()
    }
}
