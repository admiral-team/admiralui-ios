//
//  BigTabContainer.swift
//  AdmiralUI
//
//  Created on 06.11.2020.
//

import UIKit

/// Container with 3 objects - segment control, arrow slider and bottom view.
public class SegmentControlContainer<S, T>: UIControl  where S: SegmentControlContainerContent, T: UIView {
    
    // MARK: - Public Properties
    
    public var selectedSegmentIndex: Int {
        get { return segmentControl.selectedSegmentIndex }
        set { segmentControl.selectedSegmentIndex = newValue }
    }
    
    /// Returns the number of segments the receiver has.
    public var numberOfSegments: Int {
        return segmentControl.numberOfSegments
    }
    
    public override var isEnabled: Bool {
        didSet { updateStateEnabled() }
    }
    
    /// Additional bottom view
    public var bottomView: T? {
        didSet {
            oldValue?.removeFromSuperview()
            configurationBottomView(bottomView)
        }
    }
    
    /// Segment Control
    public var segmentControl: S
    
    // MARK: - Private Properties
    
    private let arrowSlider = ArrowSegmentSlider()
    private var bottomViewContainer = UIView()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the bottom view and segment control.
    public init(bottomView: T, segmentControl: S) {
        self.segmentControl = segmentControl
        super.init(frame: .zero)
        commonInit()
        
        self.setView(bottomView)
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setOffsetSlider()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [segmentControl,
         arrowSlider,
         bottomViewContainer].addToSuperview(self)
    }
    
    private func configureLayout() {
        let topSegment = segmentControl.topAnchor.constraint(equalTo: topAnchor)
        let leadingSegment = segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingSegment = trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor)
        
        let topSlider = arrowSlider.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.doubleModule)
        let leadingSlider = arrowSlider.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingSlider = trailingAnchor.constraint(equalTo: arrowSlider.trailingAnchor)
        
        let topBottomView = bottomViewContainer.topAnchor.constraint(equalTo: arrowSlider.bottomAnchor)
        let leadingBottomView = bottomViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingBottomView = trailingAnchor.constraint(equalTo: bottomViewContainer.trailingAnchor)
        let bottomBottomView = bottomAnchor.constraint(equalTo: bottomViewContainer.bottomAnchor)

        NSLayoutConstraint.activate([
            topSegment,
            leadingSegment,
            trailingSegment,
            
            topSlider,
            leadingSlider,
            trailingSlider,
            
            topBottomView,
            leadingBottomView,
            trailingBottomView,
            bottomBottomView
        ])
    }
    
    private func configureUI() {
        backgroundColor = UIColor.clear
        segmentControl.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        setOffsetSlider()
    }
    
    @objc private func segmentChange() {
        setOffsetSlider()
    }
    
    private func setOffsetSlider() {
        guard segmentControl.numberOfSegments > segmentControl.selectedSegmentIndex else {
            arrowSlider.setOffset(LayoutGrid.doubleModule, animated: false)
            return
        }

        let allSegmentWidth = arrowSlider.frame.width - LayoutGrid.module * CGFloat((segmentControl.numberOfSegments - 1))
        let segmentWidth = allSegmentWidth / CGFloat(segmentControl.numberOfSegments)
        let offset = (segmentWidth * CGFloat(segmentControl.selectedSegmentIndex + 1) - segmentWidth / 2)
            + LayoutGrid.module * CGFloat(segmentControl.selectedSegmentIndex)
        arrowSlider.setOffset(offset, animated: true)
    }
    
    private func updateStateEnabled() {
        segmentControl.isEnabled = isEnabled
    }
    
    private func configurationBottomView(_ view: T?) {
        guard let bottomView = view else { return }
        [bottomView].addToSuperview(bottomViewContainer)
        
        var constraints = bottomView.fillView(view: bottomViewContainer)
        constraints.append(bottomViewContainer.widthAnchor.constraint(equalTo: bottomView.widthAnchor))
        constraints.append(bottomViewContainer.heightAnchor.constraint(equalTo: bottomView.heightAnchor))

        NSLayoutConstraint.activate(constraints)
    }
    
    private func setView(_ view: T) {
        self.bottomView = view
    }
    
}
