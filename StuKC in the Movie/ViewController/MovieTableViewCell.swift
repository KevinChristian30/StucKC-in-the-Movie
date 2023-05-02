//
//  MovieTableViewCell.swift
//  StuKC in the Movie
//
//  Created by prk on 5/2/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var priceTF: UITextField!
    
    var onUpdateButtonClicked = {
        
    }
    
    var onDeleteButtonClicked = {
        
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        onUpdateButtonClicked()
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        onDeleteButtonClicked()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
