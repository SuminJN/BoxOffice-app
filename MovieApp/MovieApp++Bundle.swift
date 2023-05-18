import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "MovieInfo", ofType: "plist") else { return ""}
        guard let resource = NSDictionary(contentsOfFile: file) else { return ""}
        guard let key = resource["API_KEY"] as? String else { fatalError("MovieInfo.plist에서 API_KEY를 설정하세요.")}
        return key
    }
}
