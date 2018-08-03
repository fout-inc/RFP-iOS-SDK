//
// Created by FreakOut on 2018/07/23.
// Copyright (c) 2018 FreakOut. All rights reserved.
//

protocol RFPTableViewCellProtocol {

    func startTimer()

    func startTimer(interval: TimeInterval)

    func setTimerCompletion(_ completion: @escaping ((_ indexPath: IndexPath) -> Void))

    func tick()

    func getTableView() -> UITableView?

}

protocol RFPTableViewCellDelegate {
    func getPlayer(_ indexPath: IndexPath) -> RFPPlayerControl?
}

class RFPTableViewCell: UITableViewCell, RFPTableViewCellProtocol {

    var elapsed: Double = 2
    var completion: ((IndexPath) -> Void)?
    var delegate: RFPTableViewCellDelegate?

    weak var model: RFPInstreamInfoModel?
    var indexPath: IndexPath?

    var timer: Timer?
    var interval: TimeInterval = 0.1

    var startTime: Double = 0

    var topMargin: CGFloat = 0
    var bottomMargin: CGFloat = 0
    var viewableRect: CGRect = CGRect.init()
    var viewableRate: CGFloat = 0.5

    func initProperties() {
        self.timer?.invalidate()
        self.timer = nil

        self.delegate = nil
        self.completion = nil
    }

    func startTimer() {
        self.startTimer(interval: self.interval)
    }

    func startTimer(interval: TimeInterval) {
        self.interval = interval
        self.prepare()

        self.timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(
            self.timer!,
            forMode: RunLoopMode.commonModes
        )
    }

    func setTimerCompletion(_ completion: @escaping ((IndexPath) -> Void)) {
        self.completion = completion
    }

    func prepare() {
        if let tableView = self.getTableView() {
            let viewableRateMargin = self.bounds.size.height * self.viewableRate
            let topMargin = self.topMargin + viewableRateMargin

            self.viewableRect = CGRect.init(
                origin: CGPoint.init(
                    x: tableView.bounds.origin.x,
                    y: topMargin),
                size: CGSize.init(
                    width: tableView.bounds.size.width,
                    height: tableView.bounds.size.height - (topMargin) - viewableRateMargin - self.bottomMargin)
            )
        }
    }

    @objc func tick() {
        // override
    }

    func getTableView() -> UITableView? {
        var tableView = self.superview as? UITableView
        if (tableView == nil) {
            tableView = self.superview?.superview as? UITableView
        }
        return tableView
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.initProperties()
    }

    deinit {
        self.initProperties()
    }
}
