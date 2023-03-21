//
//  InstagramShare.swift
//  Tagagram
//
//  Created by Sucharu on 03/10/18.
//  Copyright © 2018 ondoor_mac1. All rights reserved.
//

import Foundation
import UIKit
import Photos



// Class that helps to share the image over the Instagram directly

@objc final class InstagramPublisher : NSObject , UIDocumentInteractionControllerDelegate {
    
    // Class Constants
    private let kInstagramURL = "instagram://app"
    private let kUTI = "com.instagram.exclusivegram"
    private let kfileNameExtension = "instagram.igo"
    private let kAlertViewTitle = "Error"
    private let kAlertViewMessage = "Please install the Instagram application"
    
    var documentInteractionController = UIDocumentInteractionController()
    
    private var documentsController:UIDocumentInteractionController = UIDocumentInteractionController()

    // Post Image via UIDocumentInteractionController
    @objc func postImage(image: UIImage,with caption: String, view: UIView, result: ((Bool)->Void)? = nil) {
        guard let instagramURL = URL(string: "instagram://app") else {
            if let result = result {
                result(false)
            }
            return
        }
        
        if UIApplication.shared.canOpenURL(instagramURL) {
            
            let jpgPath = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagrammFotoToShareName.igo")
        
            if let image = image.jpegData(compressionQuality: 1.0) {
                
                do {
                    let fileURL = URL.init(fileURLWithPath:jpgPath)
                    try image.write(to: fileURL)
                    documentsController = UIDocumentInteractionController.init(url: fileURL)
                
                    documentsController.delegate = self
                    documentsController.uti = "com.instagram.exclusivegram"
                    // documentsController.annotation = ["InstagramCaption": caption]
                    // documentsController.presentOptionsMenu(from: view.bounds, in: view, animated: true)
                    documentsController.presentOpenInMenu(from: view.bounds, in: view, animated: true)
                    if let result = result {
                        result(true)
                    }
                } catch (let e) {
                    print(e.localizedDescription)
                    result!(false)
                }
            } else if let result = result {
                result(false)
            }
        } else {
            if let result = result {
                result(false)
            }
        }
    }
    // Post Image via PHASSET
    
    func documentInteractionController(_ controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
        
    }

    @objc func shareVia(asset: PHAsset) -> Bool {
        let annotation = [UIApplication.OpenExternalURLOptionsKey.init(rawValue: "annotation"):["InstagramCaption":"Here Give what you want to share"]]
        let u = "instagram://library?LocalIdentifier=" + asset.localIdentifier
        let url = URL(string: u)!
        
        if UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options:annotation, completionHandler: nil)
            }
            
            return true
        } else {
            return false
        }
    }
    
}

