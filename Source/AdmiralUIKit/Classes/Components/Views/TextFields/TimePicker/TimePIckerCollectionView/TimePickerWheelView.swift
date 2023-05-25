//
//  TimePickerWheelView.swift
//  AdmiralUI
//
//  Created on 15.03.2021.
//

import UIKit
import AVKit

protocol TimePickerWheelViewDelegate: AnyObject {
    func timePickerWheelViewDidTap(_ view: TimePickerWheelView)
    func timePickerWheelViewViewWillBeginDragging(_ view: TimePickerWheelView)
    func timePickerWheelCurrentNumberDidChange(_ view: TimePickerWheelView)
    func timePickerWheelViewFormattedText(_ view: TimePickerWheelView, for number: Int) -> String?
}

final class TimePickerWheelView: UIView {
    
    // MARK: - Public Properties
    
    weak var delegate: TimePickerWheelViewDelegate?
    
    var currentNumber: Int {
        get { return privateCurrentNumber }
        set {
            privateCurrentNumber = newValue
            let scrollNumber = (TimeFormatter().usesAMPM() && dataSource.maxNumber == 12) ? privateCurrentNumber - 1 : privateCurrentNumber
            scrollMiddle(toNumber: scrollNumber)
        }
    }
    
    var maxNumber: Int {
        get { return dataSource.maxNumber }
        set {
            reloadData()
            dataSource.maxNumber = newValue
        }
    }
    
    var minNumber: Int {
        get { return dataSource.minNumber }
        set {
            reloadData()
            dataSource.minNumber = newValue
        }
    }
    
    var interval: Int? {
        didSet { dataSource.interval = interval }
    }
    
    var isCollectionHidden: Bool = false {
        didSet { reloadData() }
    }
    
    var itemHeight: CGFloat = 0.0 {
        didSet { updateItemSizeIfNeeded() }
    }
        
    var textAlignment: NSTextAlignment  = .center {
        didSet { reloadData() }
    }
    
    var font: UIFont = UIFont.systemFont(ofSize: 22.0) {
        didSet { reloadData() }
    }
    
    var textColor: UIColor = .black {
        didSet { reloadData() }
    }
    
    // MARK: - Private Properties
    
    private let dataSource = TimePickerInfiniteDataSource()
    private var privateCurrentNumber: Int = 0
    
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    private var isScrolling: Bool = false
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        updateItemSizeIfNeeded()
    }
    
    // MARK: - Public Properties
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func setCenterCellText(_ text: String?) {
        centerVisibleCell?.text = text
    }
    
    // MARK: - Private Properties
    
    private func commonInit() {
        configureUI()
    }

    private func configureUI() {
        collectionViewLayout = TimePickerFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        addSubview(collectionView)

        collectionViewLayout.itemSize = CGSize(width: 1, height: 1)
        collectionView.register(TimeComponentCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        collectionView.addGestureRecognizer(tap)
        
        collectionView.contentInset.top = 0
        collectionViewLayout.minimumLineSpacing = 0
        
        initialSetup()
    }
    
    @objc private func didTap() {
        delegate?.timePickerWheelViewDidTap(self)
    }
    
    private func initialSetup() {
        DispatchQueue.main.async() { [weak self] in
            guard let self = self else { return }
            self.scrollMiddle(toNumber: self.currentNumber)
        }
    }
    
    private func scrollMiddle(toNumber number: Int) {
        let index = dataSource.middleItemIndex(for: number)
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false)
    }
    
    private func updateItemSizeIfNeeded() {
        let itemSize = CGSize(width: max(1, collectionView.frame.width), height: max(1, itemHeight))
        guard itemSize != collectionViewLayout.itemSize else { return }
        collectionViewLayout.itemSize = itemSize
    }
    
}

// MARK: - UICollectionViewDelegate

extension TimePickerWheelView: UICollectionViewDelegate {
    
    var centerVisibleIndexPath: IndexPath? {
        let indexPaths = collectionView.indexPathsForVisibleItems.sorted() { $0.row < $1.row }
        guard !indexPaths.isEmpty else { return nil }
        return indexPaths[indexPaths.count / 2]
    }
    
    var centerVisibleCell: TimeComponentCollectionCell? {
        guard let indexPath = centerVisibleIndexPath else { return nil }
        return collectionView.cellForItem(at: indexPath) as? TimeComponentCollectionCell
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard
            let indexPath = centerVisibleIndexPath,
            let data = dataSource.itemData(for: indexPath.row)
        else { return }
        
        isScrolling = false
        privateCurrentNumber = data
        delegate?.timePickerWheelCurrentNumberDidChange(self)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolling = true
        delegate?.timePickerWheelViewViewWillBeginDragging(self)
    }
    
}

// MARK: - UICollectionViewDataSource

extension TimePickerWheelView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TimeComponentCollectionCell else {
            return UICollectionViewCell()
        }

        let data = dataSource.itemData(for: indexPath.row) ?? 0
        cell.text = delegate?.timePickerWheelViewFormattedText(self, for: data) ?? "\(data)"
        cell.isHidden = isCollectionHidden
        cell.textAlignment = textAlignment
        cell.textColor = textColor
        cell.font = font

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard isScrolling else { return }
        
        AudioServicesPlaySystemSound(SystemSoundID(1157))
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

}
