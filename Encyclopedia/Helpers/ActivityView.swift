//
//  CatsActivityView.swift
//  Encyclopedia
//
//  Created by  on 02/01/2022.
//

import Foundation
import UIKit

protocol ActivityViewProtocol :AnyObject {
    func showActivityIndicatory(view: UIView, _ title: String)
    func removeActivity()
}

final class ActivityView: ActivityViewProtocol {
    lazy var activityIndicator = UIActivityIndicatorView()
    lazy var strLabel = UILabel()
    lazy var effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    func showActivityIndicatory(view: UIView, _ title: String) {
        
        removeSubviews()
        
        strLabel = UILabel()
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.color = .white
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
        
        applyConstraints(with: view)
        activityIndicator.startAnimating()
    }
    
    private func applyConstraints(with view: UIView) {
        
        effectView.centerXAnchor(equalTo: view.centerXAnchor)
        effectView.centerYAnchor(equalTo: view.centerYAnchor)
        effectView.widthAnchor(equalTo: 220)
        effectView.heightAnchor(equalTo: CGFloat(47))
        
        strLabel.widthAnchor(equalTo: CGFloat(220))
        strLabel.heightAnchor(equalTo: CGFloat(47))
        strLabel.leadingAnchor(after: effectView.safeLeadingAnchor, constant: 4)
        strLabel.topAnchor(equalTo: effectView.safeTopAnchor, constant: 0)
        
        activityIndicator.centerYAnchor(equalTo: effectView.centerYAnchor)
        activityIndicator.widthAnchor(equalTo: CGFloat(30))
        activityIndicator.heightAnchor(equalTo: CGFloat(30))
        activityIndicator.leadingAnchor(after: effectView.safeLeadingAnchor, constant: 0)
    }
    
    func removeActivity() {
        activityIndicator.stopAnimating()
        removeSubviews()
    }
    
    func removeSubviews()  {
        activityIndicator.remove()
        effectView.remove()
        strLabel.remove()
    }
}



protocol AlertDelegate {
    func alert(buttonClickedIndex:Int, buttonTitle: String, tag: Int)
}
final class AlertViewController {
    class func showAlert(withTitle title: String, message:String, buttons:[String] = ["Ok"], delegate: AlertDelegate? = nil, tag: Int = 0){
        let keyWindow = UIApplication.shared.keyWindow
        
        var presentingViewController = keyWindow?.rootViewController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tag = tag
        var index = 0
        for button in buttons {
            let action =  UIAlertAction(title: button, style: .default, handler: { (alertAction) in
                
                if let d = delegate{
                    d.alert(buttonClickedIndex: index, buttonTitle: alertAction.title != nil ? alertAction.title! : title, tag: tag)
                }
            })
            alert.addAction(action)
            index = index + 1
        }
        
        while presentingViewController?.presentedViewController != nil {
            presentingViewController = presentingViewController?.presentedViewController
        }
        
        presentingViewController?.present(alert, animated: true, completion: nil)
    }
}

