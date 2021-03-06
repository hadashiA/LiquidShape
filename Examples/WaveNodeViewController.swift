import UIKit
import SpriteKit

class WaveNodeViewController : UIViewController {
    @IBOutlet weak var sceneView: SKView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scene = WaveScene(size: self.view.frame.size)
        self.sceneView.presentScene(scene)
    }
}

