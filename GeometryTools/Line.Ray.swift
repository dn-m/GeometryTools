//
//  Line.Ray.swift
//  GeometryTools
//
//  Created by James Bean on 6/20/17.
//
//

import Foundation

extension Line {

    public enum Ray {

        case up(Point)
        case down(Point)
        case left(Point)
        case right(Point)
        case slanted(point: Point, slope: Double)

        public init(_ segment: Segment) {

            if segment.start.y == segment.end.y {
                self = segment.start.x < segment.end.x
                    ? .right(segment.start)
                    : .left(segment.start)
            } else if segment.start.x == segment.end.x {
                self = segment.start.y < segment.end.y
                    ? .up(segment.start)
                    : .down(segment.start)
            } else {
                self = .slanted(point: segment.start, slope: segment.slope)
            }
        }

        public func point(at distance: Double) -> Point {
            switch self {
            case .up(let point):
                return Point(x: point.x, y: point.y + distance)
            case .down(let point):
                return Point(x: point.x, y: point.y - distance)
            case .left(let point):
                return Point(x: point.x - distance, y: point.y)
            case .right(let point):
                return Point(x: point.x + distance, y: point.y)
            case let .slanted(point, slope):
                let r = sqrt(1 + pow(slope,2))
                return Point(x: point.x + distance / r, y: point.y + (distance * slope) / r)
            }
        }
    }
}

extension Line.Ray: Equatable {

    public static func == (lhs: Line.Ray, rhs: Line.Ray) -> Bool {
        switch (lhs,rhs) {
        case let (.up(a), .up(b)):
            return a == b
        case let (.down(a), .down(b)):
            return a == b
        case let (.left(a), .left(b)):
            return a == b
        case let (.right(a), .right(b)):
            return a == b
        case let (.slanted(pointA, slopeA), .slanted(pointB, slopeB)):
            return pointA == pointB && slopeA == slopeB
        default:
            return false
        }
    }
}
