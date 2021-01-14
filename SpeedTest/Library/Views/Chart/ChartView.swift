//
//  ChartView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-14.
//

import UIKit

class ChartView: UIView {
    

    // MARK: - Private Properties
    
    private var chartLayers: [CAShapeLayer] = []
    
    
    // MARK: - Public Methos
    
    func drawCharts() {
        removeCharts()
        
        let greenChartPath = UIBezierPath()
        greenChartPath.move(to: CGPoint(x: 25, y: bounds.maxY))
        greenChartPath.addQuadCurve(to: CGPoint(x: 80, y: bounds.maxY - 30), controlPoint: CGPoint(x: 50, y: bounds.maxY - 30))
        greenChartPath.addQuadCurve(to: CGPoint(x: 200, y: bounds.maxY - 50), controlPoint: CGPoint(x: 100, y: bounds.maxY - 40))
        greenChartPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - 40))
        greenChartPath.stroke()
        
        drawChart(path: greenChartPath, strokeColor: .green)
        
        let blue = UIBezierPath()
        blue.move(to: CGPoint(x: 25, y: bounds.maxY))
        blue.addQuadCurve(to: CGPoint(x: 80, y: bounds.maxY - 100), controlPoint: CGPoint(x: 80, y: bounds.maxY - 200))
        blue.addQuadCurve(to: CGPoint(x: 200, y: bounds.maxY - 90), controlPoint: CGPoint(x: 100, y: bounds.maxY - 250))
        blue.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        blue.stroke()
        
        drawChart(path: blue, strokeColor: .blue)
    }
    
    func removeCharts() {
        chartLayers.forEach {
            $0.removeFromSuperlayer()
        }
    }
    
    func drawChart(path: UIBezierPath, strokeColor: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 2
        shapeLayer.add(animation, forKey: "DrawAnimation")
        
        chartLayers.append(shapeLayer)
        //        self.shapeLayer = shapeLayer
        
//        let gradient = CAGradientLayer()
//        gradient.frame = bounds
//        gradient.colors = [primaryColor.cgColor,
//                           UIColor.clear.cgColor]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 0, y: 1)
//        gradient.mask = shapeLayer
//
//        layer.addSublayer(gradient)
    }
    
    
    // MARK: - Helpers
    
    private func makeChart(from chartPath: UIBezierPath, primaryColor: UIColor) {
        let shapeLayer = CAShapeLayer()

        shapeLayer.strokeColor = UIColor.clear.cgColor //UIColor.green.cgColor
        shapeLayer.path = chartPath.cgPath
        shapeLayer.fillColor = primaryColor.cgColor
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [primaryColor.cgColor,
                           UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.mask = shapeLayer

        layer.addSublayer(gradient)
    }
    
    struct DataPoint {
        var pos: CGPoint
        var label: String
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        /// X Axis
        let axisPath = UIBezierPath()
        axisPath.move(to: CGPoint(x: 25, y: bounds.maxY))
        axisPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        UIColor.clear.setStroke()
        axisPath.stroke()

        /// Y Axis
        axisPath.move(to: CGPoint(x: 25, y: 0))
        axisPath.addLine(to: CGPoint(x: 25, y: bounds.maxY))
        axisPath.stroke()

        for i in 0...6 {
            let scalePoint = CGPoint(x: 0, y: bounds.height - (CGFloat(i) * bounds.height / 7.0) - 15)
            let scale = i * 50
            NSAttributedString(string: "\(scale)",
                               attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
                .draw(at: scalePoint)
        }
    }
}
