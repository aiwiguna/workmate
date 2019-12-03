//
//  Util.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation

class Util{
    
    static let shared = Util()
    
    private init() {
        
    }
    
    func saveAuthKey(key:String){
        UserDefaults.standard.set(key, forKey: "authKey")
    }
    
    func getAuthKey()->String?{
        return UserDefaults.standard.string(forKey: "authKey")
    }
    
    func saveClockInTime(date:Date){
        UserDefaults.standard.set(date, forKey: "clockInTime")
    }
    
    func getClockInTime()->Date?{
        return UserDefaults.standard.object(forKey: "clockInTime") as? Date
    }
    
    func saveClockOutTime(date:Date){
        UserDefaults.standard.set(date, forKey: "clockOutTime")
    }
    
    func getClockOutTime()->Date?{
        return UserDefaults.standard.object(forKey: "clockOutTime") as? Date
    }
    
    func clearClockTime(){
        UserDefaults.standard.removeObject(forKey: "clockInTime")
        UserDefaults.standard.removeObject(forKey: "clockOutTime")
    }
}
