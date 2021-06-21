//
//  CollectionViewController.swift
//  VKApp
//
//  Created by KKK on 04.04.2021.
//

import UIKit


class FrendCollectionViewController: UICollectionViewController {


//    var vkPhotos = VKPhotos(count: 0, items: []) {
//        didSet {
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }

    lazy var frendIndex = Int()
    
    var vkPhotos = try? RealmService
        .load(typeOf: RealmPhoto.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        readFriendPhoto(fInd: frendIndex)
        
        NetworkService().getPhotos(user_ID: String(frendIndex)) {
            realmPhotos in
//            [weak self] realmPhotos in
            do {
                try RealmService.save(items: realmPhotos)
            } catch {
                print(error)
             }
        }
    }

    private func readFriendPhoto(fInd frendIndex: Int) {
        
        self.vkPhotos = try? RealmService
            .load(typeOf: RealmPhoto.self)
            .filter(NSPredicate(format: "idUser == %i", frendIndex))
        
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)//
    //    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

//        return frendCollectionImag[frendIndex].images.count
        return vkPhotos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendCollectionViewCell", for: indexPath) as? FrendCollectionViewCell
        else { return UICollectionViewCell() }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendCollectionViewCell", for: indexPath) as! FrendCollectionViewCell

        // Configure the cell

//        cell.configate(frend: frendCollectionImag[frendIndex].images[indexPath.item])
        cell.configate(photoUrl: vkPhotos![indexPath.item].sizes[0].photoURL)
         
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
        
        destination.vkPhotos = Array(vkPhotos!)
        
        

    }

}
