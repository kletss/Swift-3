//
//  CollectionViewController.swift
//  VKApp
//
//  Created by KKK on 04.04.2021.
//

import UIKit


class FrendCollectionViewController: UICollectionViewController {

//    private lazy var line = Line()

    var vkPhotos = VKPhotos(count: 0, items: [])

   lazy var frendIndex = Int()
      
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkService().getPhotos(user_ID: String(frendIndex)) {
            [weak self] vkPhotos in self?.vkPhotos = vkPhotos
            // коллекция должна прочитать новые данные
            self?.collectionView?.reloadData()

         }
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

//        return frendCollectionImag[frendIndex].images.count
        return vkPhotos.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendCollectionViewCell", for: indexPath) as? FrendCollectionViewCell
        else { return UICollectionViewCell() }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendCollectionViewCell", for: indexPath) as! FrendCollectionViewCell

        // Configure the cell

//        cell.configate(frend: frendCollectionImag[frendIndex].images[indexPath.item])
        cell.configate(photoUrl: vkPhotos.items[indexPath.item].sizes[0].urlImage)
         
        return cell
    }

    @IBOutlet var frendCollection: UICollectionView!

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "frendImagesIdentifier" else { return }
        guard let destination = segue.destination as? FrendViewControllerImages else { return }
//        let ind = FrandsTableView.indexPathForSelectedRow
      //  destination.frend.append(frends[ind!.item])
      //  destination.frend.append(frends[ind!.section].rows[ind!.row])
//        destination.frendImage = frends[ind!.section].rows[ind!.row].id
        
        let ind = frendCollection.indexPathsForSelectedItems?.first 
        destination.indFrendCollectionImag = frendIndex
        destination.indImage = ind!.row
        destination.vkPhotos = self.vkPhotos
        
        

    }

}
