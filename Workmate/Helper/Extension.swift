//
//  Extension.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import UIKit

extension UIView{
    func circleView(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}

extension UIButton{
    func underlineText(){
        let attr: [NSAttributedString.Key: Any] = [
            .font: self.titleLabel!.font!,
            .foregroundColor: self.titleLabel!.textColor!,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let buttonTitleStr = NSMutableAttributedString(string:self.currentTitle ?? "", attributes:attr)
        self.setAttributedTitle(buttonTitleStr, for: .normal)
    }
}

extension UILabel{
    func underlineText(){
        let attr: [NSAttributedString.Key: Any] = [
            .font: self.font!,
            .foregroundColor: self.textColor!,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let title = NSMutableAttributedString(string:self.text ?? "", attributes:attr)
        self.attributedText = title
    }
}

extension Date{
    func toTime()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mma"
        return dateFormatter.string(from: self)
    }
}

extension String{
    func toCurrency()->String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "id_ID")
        return currencyFormatter.string(from: NSNumber(value: Double(self) ?? 0)) ?? "-"
    }
    
    func toDate()->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self.replacingOccurrences(of: "Z", with: "+0000"))
    }
    
    func removeUnderScore()->String{
        return self.replacingOccurrences(of: "_", with: " ")
    }
}
