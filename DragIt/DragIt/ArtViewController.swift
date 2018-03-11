//
//  ArtViewController.swift
//  DragIt
//
//  Created by Егор on 11.03.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit

class ArtViewController: UIViewController, UIDropInteractionDelegate {
    
    @IBOutlet var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    
    var imageFetcher: ImageFetcher!
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        imageFetcher = ImageFetcher() { url, image in
            DispatchQueue.main.async {
                self.artView.backgroundImage = image
            }
        }
        session.loadObjects(ofClass: NSURL.self) { nsurls in
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
            }
        }
        session.loadObjects(ofClass: NSURL.self) { images in
            if let image = images.first as? UIImage {
                self.imageFetcher.backup = image
            }
        }
    }
    
    
    @IBOutlet weak var artView: ArtView!
    
}
