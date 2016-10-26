//
//  ProfilePageViewController.swift
//  UserProfilePage
//
//  Created by Becarefullee on 16/10/25.
//  Copyright © 2016年 Becarefullee. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProfilePageViewController: UICollectionViewController {
  
  fileprivate var outfits: [UIImage] = []
  fileprivate var likes: [UIImage] = []
  fileprivate var likesSelected: Bool = false
  var header: HeaderCollectionReusableView?
  let greyColor: UIColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
  let defaultBlue: UIColor = UIColor(red: 14/255, green: 122/255, blue: 254/255, alpha: 1)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDataSource()
      
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
  
  func refresh(_ sender: AnyObject?) {
    let delayTime = DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
      self.collectionView?.refreshControl?.endRefreshing()
    }
  }
  
  func setUpDataSource() {
    for i in 0...20 {
      let j = i % 8
      if i > 7 && i < 13 {
        let likesImage = UIImage(named: "IMG_\(i)")
        likes.append(likesImage!)
      }
      let outfitImage = UIImage(named: "IMG_\(j)")
      outfits.append(outfitImage!)
    }
  }
}

//:MARK Change Section

extension ProfilePageViewController {
  @IBAction func outfitsBtnPressed(_ sender: UIButton) {
    header?.likesBtn.setTitleColor(greyColor, for: .normal)
    header?.outfitsBtn.setTitleColor(defaultBlue, for: .normal)
    likesSelected = false
    collectionView?.reloadData()
  }
  
  @IBAction func likesBtnPressed(_ sender: UIButton) {
    header?.likesBtn.setTitleColor(defaultBlue, for: .normal)
    header?.outfitsBtn.setTitleColor(greyColor, for: .normal)
    likesSelected = true
    collectionView?.reloadData()
  }
}


//:MARK CollectionView Datasource


extension ProfilePageViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if likesSelected {
      return likes.count
    }
    return outfits.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
    if likesSelected {
        cell.imageView.image = likes[indexPath.row]
    }else {
        cell.imageView.image = outfits[indexPath.row]
    }
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    switch kind {
    case UICollectionElementKindSectionHeader:
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionHeader", for: indexPath) as! HeaderCollectionReusableView
      header = headerView
      headerView.profilePicture.image = UIImage(named: "Profile")
      return headerView
    default:
      assert(false, "Unexpected element kind")
    }
    
  }
  
  
}
