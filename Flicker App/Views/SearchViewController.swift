//
//  ViewController.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 16.2.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = PhotosViewModel()
    private var photosList = [PhotoData]()
    
    private var testArray = [String:String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData(search: "")
        
        // Add prompt when collectionView has no cells
        if collectionView.visibleCells.isEmpty {
            let backGroundView = UIView(frame: collectionView.bounds)
            
            collectionView.backgroundView = backGroundView
            
            let label = UILabel()
            label.text = "Hello! You can start \n \n your search 👩‍💻"
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.numberOfLines = 0
            label.textAlignment = .center
            collectionView.backgroundView?.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
        
            label.centerXAnchor.constraint(equalTo: backGroundView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: backGroundView.centerYAnchor).isActive = true
            
        } else {
            collectionView.backgroundView = UIView()
        }
    }
    
    // MARK: - Get Data
    
    func getData(search:String) {
                
        viewModel.getPhotosList(search: search) { (list) in
            DispatchQueue.main.async {
                if list.photo.count != 0 {
                    for photo in list.photo {
                        print(photo.title)
                        self.photosList.append(PhotoData(id: photo.id, secret: photo.secret, server: photo.server, title: photo.title))
                    }
                    //clear background
                    self.collectionView.backgroundView = UIView()
                    self.collectionView.reloadData()
                } else {
                    print("Error: failed to get list")
                }
            }
        }
        
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCellView = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCellView
        
        if let title = photosList[indexPath.item].title,
           let id = photosList[indexPath.item].id,
           let secret = photosList[indexPath.item].secret,
           let server = photosList[indexPath.item].id {
            cell.img.downloaded(from: "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg")
            cell.title.text = String(describing: title)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/4.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension SearchViewController: UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
     
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.photosList.removeAll()
        guard let count = searchBar.text?.count else {return}
        
        // make a request only if the request text count 3 char or more to relevant search
        if count >= 3 {
            getData(search: searchBar.text!.lowercased())
        } else {
            let message = AlertMessage()
            message.showMessage(on: self, with: "Ooops!", message: "Please enter 3 or more symbols to search")
        }
                
    }
        
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("searchText \(searchText)")
//        getData(search: searchBar.text!.lowercased())
//    }
    
}
