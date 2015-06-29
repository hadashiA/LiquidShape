import SpriteKit

class SplashShapeNode : SKShapeNode {
    var wave: Wave
    
    init(size: CGSize) {
        self.wave = Wave(size: size, waveLength: 10)
        super.init()
        
        self.path = self.wave.createPath()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}