//
//  CollectionViewCell.swift
//  Test_App
//
//  Created by Georgie Muler on 14.06.2022.
//

import UIKit

class CollectionFileViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fileLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewButton: UIButton!
    
    var file: File? {
        didSet {
            guard let file = file else {
                return
            }
            fileLabel.text = file.name
            
            if case .file = file.type {
                imageView.image = UIImage.init(systemName: "doc.richtext.fill")
            } else if case .directory = file.type {
                imageView.image = UIImage.init(systemName: "folder")
            }
        }
    }
}
