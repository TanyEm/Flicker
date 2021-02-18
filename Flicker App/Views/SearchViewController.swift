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
        getData()
    }
    
    // MARK: - Get Data
    
    func getData() {
                
        viewModel.getPhotosList(search: "String") { (list) in
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
        
        if let unwrappedCost = photosList[indexPath.item].title{
            cell.title.text = String(describing: unwrappedCost)
        }else{
        cell.title.text = "0" //Your Value If It can't Find Cost in Class
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

