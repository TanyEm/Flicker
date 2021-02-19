//
//  UIImageView+URL.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 19.2.2021.
//

import UIKit

extension UIImageView {
    
    private var activityIndicator: UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = UIColor.black
            self.addSubview(activityIndicator)

            activityIndicator.translatesAutoresizingMaskIntoConstraints = false

            let centerX = NSLayoutConstraint(item: self,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: activityIndicator,
                                             attribute: .centerX,
                                             multiplier: 1,
                                             constant: 0)
            let centerY = NSLayoutConstraint(item: self,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: activityIndicator,
                                             attribute: .centerY,
                                             multiplier: 1,
                                             constant: 0)
            self.addConstraints([centerX, centerY])
            return activityIndicator
        }
    
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        let activityIndicator = self.activityIndicator
        activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error=\(String(describing:error))")
                activityIndicator.stopAnimating()
                return
            }
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                DispatchQueue.main.async() { [weak self] in
                    // If there no img set placeholder
                    self?.image = UIImage(named: "flickr-ikoni")
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
}
