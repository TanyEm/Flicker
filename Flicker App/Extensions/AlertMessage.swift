//
//  AlertMessage.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 19.2.2021.
//

import UIKit

struct AlertMessage {
    func showMessage(on vc:UIViewController, with title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
