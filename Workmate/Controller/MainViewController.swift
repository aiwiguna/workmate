//
//  MainViewController.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import UIKit

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
            if state == State.none{
                grayCircleView.isHidden = false
                clockStateLabel.text = "Clock In"
            }else if state == State.clockedIn{
                grayCircleView.isHidden = false
                clockStateLabel.text = "Clock Out"
            }else if state == State.clockedOut{
                grayCircleView.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        auth()
    }
    
    func auth(){
        ConnectionManager.auth(username: ConstantManager.username, password: ConstantManager.password) { (key, error) in
            if let _ = error{
                // do error handling if needed
            }else if let keyValue = key{
                Util.shared.saveAuthKey(key: keyValue.key ?? "")
                self.getStaffRequest()
            }
        }
    }
    
    func getStaffRequest(){
        ConnectionManager.getStaffRequest { (response, error) in
            if let _ = error{
                // do error handling if needed
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
    
    func setUI(){
        whiteCircleView.circleView()
        grayCircleView.circleView()
        
        if let clockInTime = Util.shared.getClockInTime(){
            clockInLabel.text = clockInTime.toTime()
            state = .clockedIn
        }else{
            state = .none
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let vc = OverlayViewController()
        vc.delegate = self
        vc.state = state
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: OverlayDelegate{
    func didSuccess() {
        
    }
    
    func didCancel() {
        // do something if needed
    }
}
