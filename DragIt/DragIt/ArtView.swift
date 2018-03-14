//
//  ArtView.swift
//  DragIt
//
//  Created by Егор on 11.03.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit

class ArtView: UIView {
    
    var backgroundImage: UIImage? { didSet { setNeedsDisplay() } }

    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
    
}
