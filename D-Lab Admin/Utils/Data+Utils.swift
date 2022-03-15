import Foundation

extension Data
{
    func printJSON()
    {
        if let json = String(data: self, encoding: String.Encoding.utf8)
        {
            print(json)
        }
    }
}
