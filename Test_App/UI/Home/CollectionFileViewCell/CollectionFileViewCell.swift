//
//  CollectionViewCell.swift
//  Test_App
//
//  Created by Georgie Muler on 14.06.2022.
//

import UIKit

class CollectionFileViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fileLabel: UILabel!
  
    func setLabel(label: String) {
        fileLabel.text = label
    }
}
