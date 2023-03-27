module QuestionsHelper
  def text_with_link_hashtag(text)
    text.gsub!(HashTag::REGEX) do |name|
      link_to(name, hash_tag_path(name))
    end

    simple_format(text)
  end
end
