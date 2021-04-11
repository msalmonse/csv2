//
//  CTX.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation

/// Cache of changes in canvas context

struct CTX {
    var dash = ""
    var fillStyle = ""
    var font = ""
    var lineCap = ""
    var lineWidth = 0.0
    var strokeStyle = ""
    var textAlign = ""
    var textBaseline = ""
    var transform = ""
}

/// Convert the alignment from Plot into canvas values
/// - Parameter textAlign: textAlign from Plot
/// - Returns: JS textAlign

fileprivate func jsAlign(_ textAlign: String) -> String {
    switch textAlign {
    case "middle": return "center"
    default: return textAlign
    }
}

/// Create a font specification from the props
/// - Parameter props: Properties
/// - Returns: Font specification

fileprivate func propsFontSpec(from props: Properties) -> String {
    var spec: [String] = []
    if props.italic { spec.append("italic") }
    if props.bold { spec.append("bold") }
    spec.append("\(props.cascade(.fontSize).f(1))px")
    spec.append(props.cascade(.fontFamily) ?? "serif")

    return spec.joined(separator: " ")
}

extension CTX {

    /// Sync context with properties
    /// - Parameters:
    ///   - props: properties to sync
    ///   - result: javascript statemants
    ///   - isText: Use the text related properties

    mutating func sync(_ props: Properties, _ result: inout [String], isText: Bool = false) {
        if isText {
            let colour = props.cascade(.fontColour) ?? "black"
            if colour != fillStyle {
                fillStyle = colour
                result.append("ctx.fillStyle = '\(colour)'")
            }

            let fontSpec = propsFontSpec(from: props)
            if fontSpec != font {
                font = fontSpec
                result.append("ctx.font = '\(font)'")
            }

            let textAlign = props.cascade(.textAlign) ?? "start"
            if textAlign != self.textAlign {
                self.textAlign = textAlign
                result.append("ctx.textAlign = '\(jsAlign(textAlign))'")
            }

            let textBaseline = props.cascade(.textBaseline) ?? "alphabetic"
            if textBaseline != self.textBaseline {
                self.textBaseline = textBaseline
                result.append("ctx.textBaseline = '\(textBaseline)'")
            }
        } else {
            let colour = props.cascade(.colour) ?? "transparent"
            if colour != strokeStyle {
                strokeStyle = colour
                result.append("ctx.strokeStyle = '\(colour)'")
            }

            let dashPattern = props.cascade(.dash) ?? ""
            if dashPattern != dash {
                dash = dashPattern
                result.append("ctx.setLineDash([\(dash)])")
            }

            let fill = props.cascade(.fill) ?? "transparent"
            if fill != fillStyle {
                fillStyle = fill
                result.append("ctx.fillStyle = '\(fill)'")
            }

            let strokeWidth = props.cascade(.strokeWidth)
            if strokeWidth > 0.0 && strokeWidth != lineWidth {
                lineWidth = strokeWidth
                result.append("ctx.lineWidth = \(strokeWidth.f(1))")
            }

            let strokeLineCap = props.cascade(.strokeLineCap) ?? "round"
            if strokeLineCap != lineCap {
                lineCap = strokeLineCap
                result.append("ctx.lineCap = '\(strokeLineCap)'")
            }
        }
        let transformMatrix = props.transform?.csv ?? ""
        if transformMatrix != transform {
            transform = transformMatrix
            result.append("ctx.setTransform(\(transform))")
        }
    }

    /// Reset any transorm that is active
    /// - Parameter result: JS to reset the transform

    mutating func resetTransform( _ result: inout [String]) {
        if transform.hasContent {
            transform = ""
            result.append("ctx.resetTransform()")
        }
    }
}
