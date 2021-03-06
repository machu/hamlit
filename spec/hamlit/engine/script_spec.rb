describe Hamlit::Engine do
  describe 'script' do
    it 'renders one-line script' do
      assert_render(<<-HAML, <<-HTML)
        = 1 + 2
        %span= 3 * 4
      HAML
        3
        <span>12</span>
      HTML
    end

    it 'renders one-line script with comment' do
      assert_render(<<-HAML, <<-HTML)
        = '#' + "#" # = 3 #
        = ['#',
          "#"]  # comment
      HAML
        ##
        ["#", "#"]
      HTML
    end

    it 'renders multi-lines script' do
      assert_render(<<-HAML, <<-HTML)
        %span
          = 1 + 2
          4 / 2
          %a= 3 - 4
      HAML
        <span>
        3
        4 / 2
        <a>-1</a>
        </span>
      HTML
    end

    it 'renders block script' do
      assert_render(<<-HAML, <<-HTML)
        = 3.times do |i|
          = i
        4
      HAML
        0
        1
        2
        3
        4
      HTML
    end

    it 'renders tag internal block script' do
      assert_render(<<-HAML, <<-HTML)
        %span
          = 1.times do |i|
            = i
      HAML
        <span>
        0
        1
        </span>
      HTML
    end

    it 'accepts a continuing script' do
      assert_render(<<-HAML, <<-HTML)
        - def foo(a, b); a + b; end
        = foo(1,
        2)
      HAML
        3
      HTML
    end

    it 'renders !=' do
      assert_render(<<-HAML, <<-HTML, escape_html: true)
        != '<"&>'
        != '<"&>'.tap do |str|
          -# no operation
      HAML
        <"&>
        <"&>
      HTML
    end

    it 'renders &=' do
      assert_render(<<-HAML, <<-HTML, escape_html: false)
        &= '<"&>'
        &= '<"&>'.tap do |str|
          -# no operation
      HAML
        &lt;&quot;&amp;&gt;
        &lt;&quot;&amp;&gt;
      HTML
    end
  end
end
