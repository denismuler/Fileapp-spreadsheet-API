//
//  TableViewCell.swift
//  Test_App
//
//  Created by Georgie Muler on 14.06.2022.
//

import UIKit

class TableFileViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    
    var file: File? {
        didSet {
            guard let file = file else {
                return
            }
            titleLabel.text = file.name
            
            if case .file = file.type {
                iconImageView.image = UIImage.init(systemName: "folder")
                arrowButton.isHidden = true
            } else if case .directory = file.type {
                iconImageView.image = UIImage.init(systemName: "doc.richtext.fill")
                arrowButton.isHidden = false
            }
        }
    }
    
}
