//
//  DetailTableViewCell.swift
//  demo_relationship_coredata
//
//  Created by Mac172 on 23/01/20.
//  Copyright © 2020 Mac172. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var name_det: UILabel!
    @IBOutlet var age_det: UILabel!
    @IBOutlet var desig_det: UILabel!
    @IBOutlet var sal_det: UILabel!
    @IBOutlet var dept_det: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
