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
    
    func saveClockInStatus(isLogin:Bool){
        UserDefaults.standard.set(isLogin, forKey: "clockedIn")
    }
    
    func getClockInStatus()->Bool{
        return UserDefaults.standard.bool(forKey: "clockedIn")
    }
    
    func saveClockInTime(date:Date){
        UserDefaults.standard.set(date, forKey: "clockInTime")
    }
    
    func getClockInTime()->Date?{
        return UserDefaults.standard.object(forKey: "clockInTime") as? Date
    }
    
    func saveLastWorkDay(date:Date){
        UserDefaults.standard.set(date, forKey: "lastWorkDay")
    }
    
    func getLastWorkDay()->Date?{
        return UserDefaults.standard.object(forKey: "lastWorkDay") as? Date
    }
}
