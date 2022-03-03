//
//  ColorPicker.swift
//  ColorPicker
//
//  Created on 16.02.2021.
//

import UIKit

public final class ColorPicker: UIControl {
    
    private(set) lazy var colorSpace: HRColorSpace = { preconditionFailure() }()

    public var color: UIColor {
        get { return hsvColor.uiColor }
    }

    private let brightnessCursor = BrightnessCursor()
    private let brightnessSlider = BrightnessSlider()
    private let colorMap = ColorMapView()
    private let colorMapCursor = ColorMapCursor()

    private lazy var hsvColor: HSVColor = { preconditionFailure() }()

    private let feedbackGenerator = UISelectionFeedbackGenerator()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(colorMap)
        addSubview(brightnessSlider)
        addSubview(brightnessCursor)
        addSubview(colorMapCursor)

        let colorMapPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleColorMapPan(pan:)))
        colorMapPan.delegate = self
        colorMap.addGestureRecognizer(colorMapPan)

        let colorMapTap = UITapGestureRecognizer(target: self, action: #selector(self.handleColorMapTap(tap:)))
        colorMapTap.delegate = self
        colorMap.addGestureRecognizer(colorMapTap)

        brightnessSlider.delegate = self

        feedbackGenerator.prepare()
    }

    public func set(color: UIColor, colorSpace: HRColorSpace = .sRGB) {
        self.colorSpace = colorSpace
        colorMap.colorSpace = colorSpace
        hsvColor = HSVColor(color: color, colorSpace: colorSpace)
        if superview != nil {
            mapColorToView(initialize: true)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        let margin: CGFloat = 12
        let brightnessSliderWidth: CGFloat = 72
        let colorMapSize = min(bounds.width - brightnessSliderWidth - margin * 3, bounds.height - 2 * margin)

        let colorMapX = (bounds.width - (colorMapSize + margin * 2 + brightnessSliderWidth)) / 2

        colorMap.frame = CGRect(x: colorMapX, y: (bounds.height - colorMapSize) / 2, width: colorMapSize + margin * 2, height: colorMapSize)
        brightnessSlider.frame = CGRect(x: colorMap.frame.maxX, y: (bounds.height - colorMapSize) / 2,
                                        width: brightnessSliderWidth, height: colorMapSize)

        let brightnessCursorSize = CGSize(width: brightnessSliderWidth, height: 28)
        brightnessCursor.frame = CGRect(x: colorMap.frame.maxX,
                                        y: (bounds.height - brightnessCursorSize.height) / 2,
                                        width: brightnessCursorSize.width, height: brightnessCursorSize.height)
        mapColorToView(initialize: true)
    }
    
    private func mapColorToView(initialize: Bool = false) {
        brightnessCursor.set(hsv: hsvColor)
        colorMap.set(brightness: hsvColor.brightness)
        colorMapCursor.center = colorMap.convert(colorMap.position(for: hsvColor.hueAndSaturation), to: self)
        colorMapCursor.set(hsvColor: hsvColor)
        brightnessSlider.set(hsColor: hsvColor.hueAndSaturation)
        if initialize {
            self.brightnessSlider.set(brightness: self.hsvColor.brightness)
        }
    }
    
    @objc
    private func handleColorMapPan(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            colorMapCursor.startEditing()
        case .cancelled, .ended, .failed:
            colorMapCursor.endEditing()
        default:
            break
        }
        let selected = colorMap.color(at: pan.location(in: colorMap))
        hsvColor = selected.with(brightness: hsvColor.brightness)
        mapColorToView()
        feedbackIfNeeds()
        sendActionIfNeeds()
    }

    @objc
    private func handleColorMapTap(tap: UITapGestureRecognizer) {
        let selectedColor = colorMap.color(at: tap.location(in: colorMap))
        hsvColor = selectedColor.with(brightness: hsvColor.brightness)
        mapColorToView()
        feedbackIfNeeds()
        sendActionIfNeeds()
    }

    private var prevFeedbackedHSV: HSVColor?
    private func feedbackIfNeeds() {
        if prevFeedbackedHSV != hsvColor {
            feedbackGenerator.selectionChanged()
            prevFeedbackedHSV = hsvColor
        }
    }

    private var prevSentActionHSV: HSVColor?
    private func sendActionIfNeeds() {
        if prevSentActionHSV != hsvColor {
            sendActions(for: .valueChanged)
            prevSentActionHSV = hsvColor
        }
    }
}

extension ColorPicker: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.view == colorMap, otherGestureRecognizer.view == colorMap {
            return true
        }
        return false
    }
}

extension ColorPicker: BrightnessSliderDelegate {
    func handleBrightnessChanged(slider: BrightnessSlider) {
        hsvColor = hsvColor.hueAndSaturation.with(brightness: slider.brightness)
        mapColorToView()
        feedbackIfNeeds()
        sendActionIfNeeds()
    }
}
