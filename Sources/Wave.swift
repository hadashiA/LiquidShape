import UIKit

class Wave {
    class Spring {
        var height: CGFloat = 0
        var velocity: CGFloat = 0
        
        func update(density: CGFloat, rippleSpeed: CGFloat) {
            self.velocity += (-rippleSpeed * self.height - density * self.velocity)
            self.height += self.velocity
        }
    }

    var size: CGSize
    var density: CGFloat = 0.02
    var rippleSpeed: CGFloat = 0.1
    var springs: [Spring]
    
    init(size: CGSize, waveLength: Int = 340) {
        self.size = size
        self.springs = [Spring](count: waveLength, repeatedValue: Spring())
    }

    func updateSprings(spread: CGFloat) {
        for spring in self.springs {
            spring.update(self.density, rippleSpeed: self.rippleSpeed)
        }
        
        var leftDeltas = [CGFloat](count: self.springs.count, repeatedValue: 0)
        var rightDeltas = [CGFloat](count: self.springs.count, repeatedValue: 0)
        
        for t in 0..<8 {
            for i in 0..<self.springs.count {
                if i > 0 {
                    leftDeltas[i] = spread * (self.springs[i].height - self.springs[i - 1].height)
                    if leftDeltas[i] != 0 {
                        println(leftDeltas[i])
                    }

                    let spring = self.springs[i - 1]
                    spring.velocity += leftDeltas[i]
                    self.springs[i - 1] = spring
                }
                if i < self.springs.count - 1 {
                    rightDeltas[i] = spread * (self.springs[i].height - self.springs[i + 1].height)
                    let spring = self.springs[i + 1]
                    spring.velocity += rightDeltas[i]
                    self.springs[i + 1] = spring
                }
            }
            
            for i in 0..<self.springs.count {
                if i > 0 {
                    let spring = self.springs[i - 1]
                    spring.height += leftDeltas[i]
                    self.springs[i - 1] = spring
                }
                if i < self.springs.count - 1 {
                    let spring = self.springs[i + 1]
                    spring.height += rightDeltas[i]
                    self.springs[i + 1] = spring
                }
            }
        }
    }
    
    func createPath() -> CGPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        for i in 0..<self.springs.count {
            let spring = self.springs[i]

            let x = CGFloat(i) * (self.size.width / CGFloat(self.springs.count))
            let y = self.size.height * 0.5 - spring.height
            path.addLineToPoint(CGPoint(x: x, y: y))
        }
        path.addLineToPoint(CGPoint(x: self.size.width, y: 0))
        path.closePath()
        return path.CGPath
    }
}