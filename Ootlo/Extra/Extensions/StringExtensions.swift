extension String
{
    func getQueryStringParameter(param: String) -> String? {
        guard let url = URLComponents(string: self) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func isBackSpace() -> Bool
    {
        let  char = self.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            return true
        }
        return false
    }
    
    //For convert value string to bool which contain y, yes, t, true or 1
    func toBool() -> Bool
    {
        return (self.lowercased() == "y" || self.lowercased() == "yes" || self.lowercased() == "t" || self.lowercased() == "true" || self == "1") ? true : false
    }
    
    //For convert value string to bool with custom true value
    func toBool(trueValue: String) -> Bool
    {
        return (self.lowercased() == trueValue.lowercased()) ? true : false
    }
    
    func toInt() -> Int
    {
        return Int(self) ?? 0
    }
    func toFloat() -> Float    {
        return Float(self) ?? 0
    }
    
    
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
