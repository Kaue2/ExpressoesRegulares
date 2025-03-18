class Document
    def initialize(document)
        @document = document
        @content = ""
    end

    def read_document()
        File.open("test.txt", "r") do |archive|
            @content = archive.read
            puts @content
        end
    end
end