require 'js' # https://ruby.github.io/ruby.wasm/JS.html

# https://hparker.xyz/ruby_todo.html # example app
class Story

  attr_accessor :level, :path

  def load
    self.level = 0
    self.path = []
    render_leaf
    render_choice_listener(:left)
    render_choice_listener(:right)
  end

  private

  def document
    JS.global[:document]
  end

  def element(id)
    document.getElementById(id)
  end

  def key
    "#{level}#{path.join}"
  end

  def show(id)
    element(id)[:style][:display] = 'block'
  end

  def hide(id)
    element(id)[:style][:display] = 'none'
  end

  def leaf
    LEAVES[key]
  end

  def render_leaf
    img = document.createElement('img')
    img[:src] = "#{key}.png"
    img[:className] = 'rounded img-fluid mb-2'
    element('content').append(img)
    if end_of_story?
      paragraphs = [leaf[:content]].flatten
      paragraphs.each do |p_content|
        p = document.createElement("p")
        p[:textContent] = p_content
        element('content').append(p)
      end
      p = document.createElement("p")
      p[:textContent] = "The End."
      element('content').append(p)
      hide('left-link')
      hide('right-link')
    else
      span = document.createElement("span")
      span[:id] = "elipsis"
      span[:textContent] = "..."
      paragraphs = [leaf[:content]].flatten
      paragraphs.each_with_index do |p_content, index|
        p = document.createElement("p")
        if index == paragraphs.size - 1
          p[:textContent] = "#{p_content} "
          p.append(span)
        else
          p[:textContent] = p_content
        end
        element('content').append(p)
      end
      element('left-link')[:innerText] = leaf[:left]
      element('right-link')[:innerText] = leaf[:right]
    end
    element('footer').scrollIntoView(false)
  end

  def end_of_story?
    leaf[:left].nil? && leaf[:right].nil?
  end

  def render_choice_listener(direction)
    element("#{direction}-link").addEventListener("click") do |event|
      element("elipsis").replaceWith("#{leaf[direction]}.")
      self.level += 1
      self.path << (direction == :left ? "l" : "r")
      render_leaf
    end
  end

end
