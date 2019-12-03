//
//  OverlayViewController.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import UIKit

protocol OverlayDelegate {
    func didSuccess()
    func didCancel()
}

class OverlayViewController: UIViewController {

    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var currentProgressView: UIView!
    
    var delegate:OverlayDelegate?
    var state:State?
    var timer:Timer?
    var progressValue:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTimer()
    }
    
    func setupTimer(){
        if timer == nil{
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                DispatchQueue.main.async {
                    if self.progressValue <= 1{
                    self.progressValue += 0.001
                    self.currentProgressView.frame.size = CGSize(width: self.progressView.frame.width * self.progressValue, height: self.progressView.frame.height)
                    }else{
                        self.dismiss(animated: true) {
                            self.delegate?.didSuccess()
                        }
                    }
                }
            })
        }
    }
    
    func setupUI(){
        cancelButton.underlineText()
        if let stateValue = state{
            switch stateValue {
            case .none:
                stateLabel.text = "Clocking In..."
            case .clockedIn:
                stateLabel.text = "Clocking Out..."
            default:
                stateLabel.text = ""
            }
        }
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.didCancel()
        }
    }
}
