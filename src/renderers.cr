require "sqlite3"

module Clinl::Website::Templates


  class PageMeta
    JSON.mapping(
      name: String,
      date: Date,
      author: String
    )
  end

  class PageContent
    def initialize(@metadata : PageMeta, @content : String)
    end

    ECR.def_to_s "templates/page.ecr"
  end

  class Page
    def initialize(@content : String)
    end

    ECR.def_to_s "templates/page_container.ecr"
  end

  def page(name : String)
    metadata = File.open("/data/pages/" + name + ".json") do |file|
      PageMeta.from_json(file)
    end
	md_html = Markdown.parse(File.read("/data/pages/" + name + ".md")).to_html
	
	return Page.new(
		PageContent.new(
			metadata, md_html
		).to_s
	).to_s
  end

  def blogpost(name : String)
    metadata = File.open("/data/blog/" + name + ".json") do |file|
      PageMeta.from_json(file)
    end
    md_html = Markdown.parse(File.read("/data/blog/" + name + ".md")).to_html
	
	return Page.new(
		PageContent.new(
			metadata, md_html
		).to_s
	).to_s
  end

  def summaries(skip : Int32)
  
  end

  def links

  end

  def events

  end

  def votes
	
  end

  def finished_votes(skip : Int32)

  end

  def export_votes

  end
end
