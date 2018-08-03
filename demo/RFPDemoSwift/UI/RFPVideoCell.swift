//
//  RFPVideoCell.swift
//  RFPDemoSwift
//
//  Created by FreakOut on 2018/07/27.
//  Copyright © 2018年 FreakOut inc.,. All rights reserved.
//

import UIKit

class RFPVideoCell: RFPTableViewCell {

    @IBOutlet weak var advertiser: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    @IBOutlet weak var containerView: UIView!

    open static let fixedHeight: CGFloat = 320

    enum PlayerStatus: Int {
        case ready
        case played
    }

    private var playerStatus: PlayerStatus = PlayerStatus.ready

    override func awakeFromNib() {
        super.awakeFromNib()

        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = .lightGray
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.clearPlayerControl()
        self.startTime = 0
        self.model = nil
        self.indexPath = nil
        self.completion = nil
    }

    override func initProperties() {
        self.clearPlayerControl()
        self.startTime = 0
        self.model = nil
        self.indexPath = nil
        self.completion = nil
        self.playerStatus = PlayerStatus.ready
        self.viewableRect = CGRect.init()

        actionButton.removeTarget(nil, action: nil, for: .allEvents)

        super.initProperties()
    }

    func clearPlayerControl() {
        self.containerView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        if (self.delegate != nil && indexPath != nil) {
            if let player = self.delegate!.getPlayer(indexPath!) {
                player.pause()
                player.removeFromSuperview()
            }
        }
    }

    func setMargin(top: CGFloat, bottom: CGFloat) {
        self.topMargin = top
        self.bottomMargin = bottom
    }

    override func tick() {
        let tableView = self.getTableView()
        if (tableView != nil && self.delegate != nil && self.indexPath != nil) {
            if let player = self.delegate!.getPlayer(self.indexPath!) {

                let cellRect = tableView!.convert(
                    tableView!.rectForRow(at: self.indexPath!),
                    to: tableView!.superview!
                )

                if (self.viewableRect.intersects(cellRect)) {
                    //// viewable
                    if (self.playerStatus == PlayerStatus.ready) {
                        self.playerStatus = PlayerStatus.played
                        player.play()
                    }
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
                    if (self.playerStatus == PlayerStatus.played) {
                        self.playerStatus = PlayerStatus.ready
                        player.pause()
                    }
                }
            }
        }
    }
}
