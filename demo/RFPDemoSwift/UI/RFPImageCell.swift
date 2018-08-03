//
//  RFPImageCell.swift
//  RFPDemoSwift
//
//  Created by FreakOut on 2018/07/27.
//  Copyright © 2018年 FreakOut inc.,. All rights reserved.
//

import UIKit

class RFPImageCell: RFPTableViewCell {

    @IBOutlet weak var advertiser: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    @IBOutlet weak var containerView: UIImageView!

    open static let fixedHeight: CGFloat = 320

    override func awakeFromNib() {
        super.awakeFromNib()

        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = .lightGray
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.startTime = 0
        self.model = nil
        self.indexPath = nil
        self.completion = nil
    }

    override func initProperties() {
        self.startTime = 0
        self.model = nil
        self.indexPath = nil
        self.completion = nil
        self.viewableRect = CGRect.init()

        self.containerView.subviews.forEach { view in
            view.removeFromSuperview()
        }

        self.actionButton.removeTarget(nil, action: nil, for: .allEvents)

        super.initProperties()
    }

    func setMargin(top: CGFloat, bottom: CGFloat) {
        self.topMargin = top
        self.bottomMargin = bottom
    }

    override func tick() {
        let tableView = self.getTableView()
        if (tableView != nil && self.indexPath != nil && tableView!.superview != nil) {

            let cellRect = tableView!.convert(
                tableView!.rectForRow(at: self.indexPath!),
                to: tableView!.superview!
            )

            if (self.viewableRect.intersects(cellRect)) {
                // viewable
                if (self.startTime == 0) {
                    self.startTime = Date().timeIntervalSince1970
                } else {
                    if (self.elapsed <= (Date().timeIntervalSince1970 - self.startTime)) {
                        if (self.completion != nil) {
                            self.completion!(self.indexPath!)
                            self.startTime = Double.infinity
                        }
                    }
                }
            } else {
                //// unviewable
                if (self.startTime != Double.infinity) {
                    self.startTime = 0
                }
            }
        }
    }
}
