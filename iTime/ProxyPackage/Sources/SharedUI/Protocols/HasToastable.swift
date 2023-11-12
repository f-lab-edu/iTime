//
//  HasToastable.swift
//  TaxiDispatch
//
//  Created by 이상헌 on 2023/08/09.
//

import RxSwift

import UIKit

protocol HasToastable: AnyObject {
    func showToast(message: String, font: UIFont)
}

extension HasToastable where Self: UIViewController {
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.center.x - 75, y: self.view.center.y - 17.5, width: 150, height: 35))
           toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
           toastLabel.textColor = UIColor.white
           toastLabel.font = font
           toastLabel.textAlignment = .center;
           toastLabel.text = message
           toastLabel.alpha = 1.0
           toastLabel.layer.cornerRadius = 10;
           toastLabel.clipsToBounds  =  true
           self.view.addSubview(toastLabel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        })
       }
}
