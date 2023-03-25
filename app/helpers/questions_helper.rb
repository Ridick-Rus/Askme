module QuestionsHelper
  def parse_tags(line)
    line.split(/(#[[:alpha:]][[:word:]]+)/).map do |element|
      if element.match(/#[[:alpha:]][[:word:]]+/)
        link_to(element, hash_tag_path(element.delete("#")), class: "in-text-hash-tag")
      else
        element
      end
    end
  end
end
