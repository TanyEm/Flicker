//
//  ViewController.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 16.2.2021.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkManager
            .shared
            .sendRequest(search: "apple", method: .get)
    }


}

extension ViewController: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "description":
            print(attributeDict["description"])
        default:
            print("hello")
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print(string)
    }
    
}
