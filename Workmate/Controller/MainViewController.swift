//
//  MainViewController.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var clockStateLabel: UILabel!
    @IBOutlet weak var whiteCircleView: UIView!
    @IBOutlet weak var grayCircleView: UIView!
    @IBOutlet weak var clockOutLabel: UILabel!
    @IBOutlet weak var clockInLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var managerNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wageTypeLabel: UILabel!
    @IBOutlet weak var wageLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    var state:State = State.none {
        didSet{
            DispatchQueue.main.async {
                if self.state == State.none{
                    Util.shared.clearClockTime()
                    self.grayCircleView.isHidden = false
                    self.clockStateLabel.text = "Clock In"
                    self.clockInLabel.text = "-"
                    self.clockOutLabel.text = "-"
                }else if self.state == State.clockedIn{
                    if let clockInTime = Util.shared.getClockInTime(){
                        self.clockInLabel.text = clockInTime.toTime()
                    }
                    self.grayCircleView.isHidden = false
                    self.clockStateLabel.text = "Clock Out"
                }else if self.state == State.clockedOut{
                    if let clockOutTime = Util.shared.getClockOutTime(){
                        self.clockOutLabel.text = clockOutTime.toTime()
                    }
                    self.grayCircleView.isHidden = true
                }
            }
        }
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        auth()
    }
    
    func auth(){
        ConnectionManager.auth(username: ConstantManager.username, password: ConstantManager.password) { (key, error) in
            if let errorValue = error{
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: errorValue.localizedDescription)
                }
            }else if let keyValue = key{
                Util.shared.saveAuthKey(key: keyValue.key ?? "")
                // set key with temporary value that work because key from response give "Invalid username/password." response
//                Util.shared.saveAuthKey(key: ConstantManager.temporaryKey)
                self.getStaffRequest()
            }
        }
    }
    
    func getStaffRequest(){
        ConnectionManager.getStaffRequest { (response, error) in
            if let errorValue = error{
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: errorValue.localizedDescription)
                }
            }else if let responseValue = response{
                DispatchQueue.main.async {
                    self.titleLabel.text = responseValue.title ?? "-"
                    self.wageLabel.text = responseValue.wageAmount?.toCurrency()
                    self.wageTypeLabel.text = responseValue.wageType?.removeUnderScore() ?? "-"
                    self.positionLabel.text = responseValue.position?.name ?? "-"
                    
                    self.addressLabel.text = response?.location?.address?.street1 ?? "-"
                    self.managerNameLabel.text = response?.manager?.name ?? "-"
                    self.contactNumberLabel.text = response?.manager?.phone ?? "-"
                }
                
            }
        }
    }
    
    func clockIn(lat:String, lng:String){
        ConnectionManager.clockIn(lat: lat, lng: lng) { (clocked, clockedError,error) in
            if let errorValue = error{
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: errorValue.localizedDescription)
                }
            }else if let errorValue = clockedError{
                DispatchQueue.main.async {
                    if errorValue.code == "already_clocked_in"{
                        self.state = .clockedIn
                    }
                    self.showAlert(title: "Error", message: errorValue.detail ?? "")
                }
            }else if let response = clocked{
                if let time = response.clockInTime?.toDate(){
                    Util.shared.saveClockInTime(date: time)
                    self.state = .clockedIn
                }
            }
        }
    }
    
    func clockOut(lat:String, lng:String){
        ConnectionManager.clockOut(lat: lat, lng: lng) { (clocked, clockedError, error) in
            if let errorValue = error{
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: errorValue.localizedDescription)
                }
            }else if let errorValue = clockedError{
                DispatchQueue.main.async {
                    if errorValue.code == "already_clocked_out"{
                        self.state = .none
                    }
                    self.showAlert(title: "Error", message: errorValue.detail ?? "")
                }
            }else if let response = clocked{
                if let time = response.timesheet.clockInTime?.toDate(){
                    Util.shared.saveClockOutTime(date: time)
                    self.state = .clockedOut
                }
            }
        }
    }
    
    func setUI(){
        whiteCircleView.circleView()
        grayCircleView.circleView()
        
        contactNumberLabel.underlineText()
        
        if let clockInTime = Util.shared.getClockInTime(){
            clockInLabel.text = clockInTime.toTime()
            state = .clockedIn
        }
        
        if let _ = Util.shared.getClockOutTime(){
            state = .none
        }
    }
    @IBAction func phoneTapped(_ sender: Any) {
        if let url = URL(string: "tel://\(contactNumberLabel.text ?? "")") {
          UIApplication.shared.open(url)
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        setupLocation()
    }
    
    func setupLocation(){
        locationManager.delegate = self
        let status =  CLLocationManager.authorizationStatus()
        if status != .authorizedAlways && status != .authorizedWhenInUse{
            locationManager.requestWhenInUseAuthorization()
            return
        }
        if !CLLocationManager.locationServicesEnabled(){
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        
        // open overlay if can access location
        openOverlay()
    }
    
    func openOverlay(){
        let vc = OverlayViewController()
        vc.delegate = self
        vc.state = state
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title:String,message:String){
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            vc.dismiss(animated: true, completion: nil)
        }))
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: OverlayDelegate{
    func didSuccess(state:State) {
        guard let coordinate = locationManager.location?.coordinate else {return}
        if state == .none{
            clockIn(lat: "\(coordinate.latitude)", lng: "\(coordinate.longitude)")
        }else if state == .clockedIn{
            clockOut(lat: "\(coordinate.latitude)", lng: "\(coordinate.longitude)")
        }
    }
    
    func didCancel() {
        // do something if needed
    }
}

extension MainViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            setupLocation()
        }
    }
}
