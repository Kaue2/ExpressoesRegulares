require_relative "../includes/document.rb"

document = Document.new("../includes/test.txt")
document.read_document()
document.search("h")