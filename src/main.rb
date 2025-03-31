require_relative "../includes/document.rb"

document = Document.new("../includes/test.txt")
document.read_document()
document.search("p", false)
document.generate_tasks()