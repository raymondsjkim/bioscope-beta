//
//  PreviewViewController.swift
//  bioscope-beta
//
//  Created by HoHo on 9/20/18.
//  Copyright © 2018 Raymond Kim. All rights reserved.
//

import UIKit
import Photos

class PreviewViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    var image: UIImage!
    
    //Save to custom album
    var assetCollection: PHAssetCollection!
    var albumFound : Bool = false
    var photosAsset: PHFetchResult<AnyObject>!
    var assetThumbnailSize:CGSize!
    var collection: PHAssetCollection!
    var assetCollectionPlaceholder: PHObjectPlaceholder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton_TouchUpInside(_ sender: Any) {
        guard let imageToSave = image else {
            return
        }
        //UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        
//        CustomPhotoAlbum.shared.save(imageToSave)
//        let album = CustomPhotoAlbum("bioScope-Beta")
//        album.save(image)
        MyAwesomeAlbum.shared.save(image: image)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    //To create Album
//    func createAlbum() {
//        //Get PHFetch Options
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.predicate = NSPredicate(format: "title = %@", "bioScope-Beta")
//        let collection : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
//        //Check return value - If found, then get the first album out
//        if let _: AnyObject = collection.firstObject {
//            self.albumFound = true
//            assetCollection = collection.firstObject as! PHAssetCollection
//        } else {
//            //If not found - Then create a new album
//            PHPhotoLibrary.shared().performChanges({
//                let createAlbumRequest : PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: "bioScope-Beta")
//                self.assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
//            }, completionHandler: { success, error in
//                self.albumFound = success
//
//                if (success) {
//                    let collectionFetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [self.assetCollectionPlaceholder.localIdentifier], options: nil)
//                    print(collectionFetchResult)
//                    self.assetCollection = collectionFetchResult.firstObject as! PHAssetCollection
//                }
//            })
//        }
//    }
//
//    //to save image
//    func saveImage(){
//        PHPhotoLibrary.shared().performChanges({
//            let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
//            let assetPlaceholder = assetRequest.placeholderForCreatedAsset
//            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection, assets: self.photosAsset as! PHFetchResult<PHAsset>)
//            //albumChangeRequest!.addAssets([assetPlaceholder!])
//            let enumeration: NSArray = [assetPlaceholder!]
//            albumChangeRequest!.addAssets(enumeration)
//        }, completionHandler: { success, error in
//            print("added image to album")
//            print(error)
//
//            self.showImages()
//        })
//    }
//
//    //to show image
//    func showImages() {
//        //This will fetch all the assets in the collection
//
//        let assets : PHFetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
//        print(assets)
//
//        let imageManager = PHCachingImageManager()
//        //Enumerating objects to get a chached image - This is to save loading time
//        assets.enumerateObjects{(object: AnyObject!,
//            count: Int,
//            stop: UnsafeMutablePointer<ObjCBool>) in
//
//            if object is PHAsset {
//                let asset = object as! PHAsset
//                print(asset)
//
//                let imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
//
//                let options = PHImageRequestOptions()
//                options.deliveryMode = .fastFormat
//
//                imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options, resultHandler: {(image: UIImage?,
//                    info: [NSObject : AnyObject]?) in
//                    print(info)
//                    print(image)
//                    } as! (UIImage?, [AnyHashable : Any]?) -> Void)
//            }
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

