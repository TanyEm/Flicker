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
                    self.collectionView.reloadData()
                } else {
                    print("Error: failed to get restaurant list")
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
        getData(search: searchBar.text!.lowercased())
    }
        
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("searchText \(searchText)")
//        getData(search: searchBar.text!.lowercased())
//    }
    
}
