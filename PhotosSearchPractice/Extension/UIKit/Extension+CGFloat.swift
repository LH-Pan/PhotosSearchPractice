import UIKit

enum Simulator {
    
    case iPhone11
    
    var width: CGFloat {
        
        switch self {
            
        case .iPhone11: return 424
        }
    }
    
    var height: CGFloat {
        
        switch self {
            
        case .iPhone11: return 896
        }
    }
}

extension CGFloat {
    
    func convertWithSimulatorWidth(_ simulator: Simulator = .iPhone11) -> CGFloat {
        
        return self / simulator.width * UIScreen.width
    }
    
    func convertWithSimulatorHeight(_ simulator: Simulator = .iPhone11) -> CGFloat {
        
        return self / simulator.height * UIScreen.height
    }
}
