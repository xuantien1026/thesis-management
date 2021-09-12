class DocxTemplateGenerator
  def initialize(template_path, single_bookmarks = {}, multiple_lines_bookmarks = {})
    @template_path = template_path
    @single_bookmarks = single_bookmarks
    @multiple_lines_bookmarks = multiple_lines_bookmarks
  end

  def generate
    doc = ::Docx::Document.new(@template_path)
    @single_bookmarks.each do |key, value|
      doc.bookmarks[key.to_s].insert_text_before(value)
    end
    @multiple_lines_bookmarks.each do |key, value|
      doc.bookmarks[key.to_s].insert_multiple_lines(value)
    end
    doc.save(file_path)
    file_path
  end

  def file_path
    @file_path ||= "tmp/#{SecureRandom.uuid}.docx"
  end
end
