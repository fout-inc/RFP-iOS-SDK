//
//  FeedTableViewController.swift
//  RFPDemoSwift
//
//  Created by FreakOut on 2018/07/27.
//  Copyright © 2018年 FreakOut inc.,. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController
    , RFPInstreamAdLoaderDelegate
    , RFPExceptionDelegate
    , RFPTableViewCellDelegate {

    let videoElapsed: Double = 2.0
    let imageElapsed: Double = 1.0

    // App contents
    var contents: [AnyObject] = [
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
    ]

    // RFP data
    var infoModels: [Int: RFPInstreamInfoModel] = Dictionary.init()
    var playerControls: [IndexPath: RFPPlayerControl] = Dictionary.init()

    let adSpotId = "Set your ad spot id"
    let positions = [2, 8, 14, 20]

    let adLoader = RFPInstreamAdLoader.init()

    var topMargin: CGFloat = 0.0
    var bottomMargin: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        print("FeedTableViewController viewDidLoad")

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            UINib(nibName: "RFPContentCell", bundle: nil),
            forCellReuseIdentifier: "ContentCell"
        )

        tableView.register(
            UINib(nibName: "RFPVideoCell", bundle: nil),
            forCellReuseIdentifier: "VideoCell"
        )
        tableView.register(
            UINib(nibName: "RFPImageCell", bundle: nil),
            forCellReuseIdentifier: "ImageCell"
        )

        topMargin = UIApplication.shared.statusBarFrame.size.height
            + (navigationController?.navigationBar.frame.size.height)!
        bottomMargin = 0

        // Load RFP advertisements
        adLoader.delegate = self
        adLoader.exceptionDelegate = self
        adLoader.rfpLoadAd(
            withReturn: adSpotId,
            adCount: UInt(positions.count),
            positions: positions
        )
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        dismiss(animated: false, completion: nil)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        super.dismiss(animated: flag, completion: completion)

        self.playerControls.forEach { pc in
            pc.value.pause()
            pc.value.removeFromSuperview()
        }
        self.playerControls.removeAll()

        self.infoModels.removeAll()
    }

    // MARK: - RFPInstreamAdLoaderDelegate

    func rfpInstreamAdLoaderDidFinishLoadingAd(withReturn instreamAdLoader: RFPInstreamAdLoader!, instreamInfoModels: [Any]!) {
        if instreamInfoModels.count < 1 {
            NSLog("_items is invalid. Something wrong occur");
            return
        }

        for info in instreamInfoModels as! [RFPInstreamInfoModel] {
            contents.insert(info, at: info.position.intValue)
            infoModels[info.position.intValue] = info
        }
        tableView.reloadData()
    }

    func viewControllerForPresentingModalView() -> UIViewController! {
        return self
    }

    func readyToPlay(with playerControl: RFPPlayerControl!) {
        playerControls.forEach { pc in
            if (pc.value == playerControl) {
                if let cell = self.tableView.cellForRow(at: pc.key) as? RFPVideoCell {
                    cell.setMargin(
                        top: topMargin,
                        bottom: bottomMargin
                    )
                    cell.startTimer()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // invalid section
        if indexPath.section != 0 {
            return UITableViewCell()
        }

        // cell
        let cell: UITableViewCell

        if !isAdCellAt(indexPath) {
            // contentCell
            cell = createContentCell(contents: contents[indexPath.row], indexPath: indexPath)
        } else {
            let item: RFPInstreamInfoModel = contents[indexPath.row] as! RFPInstreamInfoModel

            if (item.isVideo()) {
                // videoCell
                cell = createVideoCell(instreamInfoModel: item, indexPath: indexPath)
            } else {
                // imageCell
                cell = createImageCell(instreamInfoModel: item, indexPath: indexPath)
            }

            // viewable impression
            (cell as! RFPTableViewCellProtocol).setTimerCompletion({ [weak self] indexPath in
                guard let `self` = self else {
                    return
                }
                self.adLoader.rfpMeasureImp(self.infoModels[indexPath.row])
                print("[viewable imp]", indexPath)
            })
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ad
        if isAdCellAt(indexPath) {
            let item: RFPInstreamInfoModel = contents[indexPath.row] as! RFPInstreamInfoModel
            if item.isVideo() {
                // videoCell
                return RFPVideoCell.fixedHeight
            }
            // imageCell
            return RFPImageCell.fixedHeight
        }
        // contentCell
        return RFPContentCell.fixedHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at", indexPath)
    }

    // MARK: - Custom func

    func isAdCellAt(_ indexPath: IndexPath) -> Bool {
        let item: AnyObject = contents[indexPath.row]

        if item is RFPInstreamInfoProtocol {
            return true
        }
        return false
    }

    func createContentCell(contents: AnyObject, indexPath: IndexPath) -> UITableViewCell {
        // cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ContentCell",
            for: indexPath) as! RFPContentCell

        // image
        let imageName = String(describing: contents)
        let imageView = UIImageView(frame: cell.bounds)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: imageName + ".jpg")
        cell.container.addSubview(imageView)

        // text
        cell.title.text = imageName

        return cell
    }

    func createVideoCell(instreamInfoModel: RFPInstreamInfoModel, indexPath: IndexPath) -> UITableViewCell {
        // cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! RFPVideoCell

        // layout
        cell.selectionStyle = .none
        cell.layoutIfNeeded()

        // settings
        cell.model = instreamInfoModel
        cell.indexPath = indexPath
        cell.elapsed = self.videoElapsed
        cell.delegate = self

        // text
        cell.advertiser.text = instreamInfoModel.displayedAdvertiser
        cell.title.text = instreamInfoModel.title
        cell.descript.text = instreamInfoModel.content

        // button
        if let ctaTitle = instreamInfoModel.getCtaText() {
            cell.actionButton.setTitle(ctaTitle, for: .normal)
        }
        cell.actionButton.addTarget(
            self,
            action: #selector(actionButtonTapped),
            for: .touchUpInside
        )

        // player
        if let pc = self.playerControls[indexPath] {
            cell.clearPlayerControl()
            cell.containerView.addSubview(pc)
        } else {
            if let playerControl: RFPPlayerControl? = adLoader.getVideoControl(
                withFrame: cell.containerView.bounds,
                infoModel: instreamInfoModel) {

                // Set tap action - https://fout.github.io/RFP-iOS-SDK/programming-guide/2_5/#infeed/video/tapped
                playerControl!.setTapActionFullscreen()

                cell.containerView.addSubview(playerControl!)
                self.playerControls[indexPath] = playerControl
            }
        }

        return cell;
    }

    func createImageCell(instreamInfoModel: RFPInstreamInfoModel, indexPath: IndexPath) -> UITableViewCell {
        // cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! RFPImageCell

        // layout
        cell.selectionStyle = .none
        cell.layoutIfNeeded()

        // settings
        cell.indexPath = indexPath
        cell.model = instreamInfoModel
        cell.elapsed = self.imageElapsed
        cell.delegate = self

        // text
        cell.advertiser.text = instreamInfoModel.displayedAdvertiser
        cell.title.text = instreamInfoModel.title
        cell.descript.text = instreamInfoModel.content

        // button
        cell.actionButton.addTarget(
            self,
            action: #selector(actionButtonTapped),
            for: .touchUpInside
        )

        // image
        let imageView = UIImageView(frame: cell.containerView.bounds)
        imageView.contentMode = .scaleAspectFill
        instreamInfoModel.rfpLoadImage(imageView, completion: { (error: Error?) -> Void in
            if (error != nil) {
                print("rfpLoadImage error", error!)
            } else {
                cell.containerView.addSubview(imageView)
                cell.startTimer()
            }
        })

        return cell;
    }

    @objc func actionButtonTapped(_ sender: UIButton, _ event: UIEvent) {
        var recursiveSearch: ((UIView) -> Void)?
        recursiveSearch = { [weak self] view in
            guard let `self` = self else {
                return
            }
            guard let superview = view.superview else {
                return
            }

            if let cell = superview as? RFPTableViewCell {
                self.adLoader.rfpSendClickEvent(cell.model)
            } else {
                recursiveSearch?(superview)
            }
        }
        recursiveSearch?(sender)
    }

    // MARK: - RFPTableViewCell delegate methods

    func getPlayer(_ indexPath: IndexPath) -> RFPPlayerControl? {
        if let player = self.playerControls[indexPath] {
            return player
        }
        return nil
    }
}
