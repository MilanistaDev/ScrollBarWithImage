//
//  ViewController.swift
//  ScrollBarWithImage
//
//  Created by Takuya Aso on 2019/09/21.
//  Copyright © 2019 Takuya Aso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let cellName = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ScrollBar with Image"
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        cell.textLabel?.text = "Cell " + String(indexPath.row)
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if #available(iOS 13.0, *) {
            // スクロールバーに画像をセット
            if let verticalScrollIndicator: UIView = scrollView.subviews.last {
                // 追加した画像があれば削除
                let subviews = verticalScrollIndicator.subviews
                for subview in subviews {
                    subview.removeFromSuperview()
                }
                let scrollBarImageView = UIImageView.init(frame: .zero)
                scrollBarImageView.contentMode = .scaleToFill
                scrollBarImageView.image = UIImage(named: "scrollBarImage")
                scrollBarImageView.translatesAutoresizingMaskIntoConstraints = false
                verticalScrollIndicator.addSubview(scrollBarImageView)
                // ScrollBar いっぱいに画像を設置
                scrollBarImageView.leadingAnchor.constraint(
                    equalTo: verticalScrollIndicator.leadingAnchor,
                    constant: 0.0
                    ).isActive = true
                scrollBarImageView.bottomAnchor.constraint(
                    equalTo: verticalScrollIndicator.bottomAnchor,
                    constant: 0.0
                    ).isActive = true
                scrollBarImageView.trailingAnchor.constraint(
                    equalTo: verticalScrollIndicator.trailingAnchor,
                    constant: 0.0
                    ).isActive = true
                scrollBarImageView.topAnchor.constraint(
                    equalTo: verticalScrollIndicator.topAnchor,
                    constant: 0.0
                ).isActive = true
            }
        } else {
            let verticalScrollIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 1)] as! UIImageView)
            verticalScrollIndicator.image = UIImage(named: "scrollBarImage")
        }
    }
}
